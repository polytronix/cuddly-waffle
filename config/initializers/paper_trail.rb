module PaperTrail
  class Version < ActiveRecord::Base
    attr_accessible :columns_changed, :phase_change, :area_after

    default_scope { where(tenant_id: Tenant.current_id) if Tenant.current_id }
    scope :history, -> { joins('INNER JOIN films ON films.id = versions.item_id').where( films: { deleted: false }).order('versions.created_at DESC') } 
    scope :before_date, ->(date) { where("created_at <= ?", date) } 
    scope :after_date, ->(date) { where("created_at >= ?", date) } 
    scope :movements, -> { where("'phase' = ANY (columns_changed)") }

    def after
      self.next ? self.next.reify : Film.find(item_id)
    end

    def datetime_display
      if created_at.year == Time.zone.today.year
        created_at.strftime("%e %b %R")
      else
        created_at.strftime("%F %R")
      end
    end

    def self.search_date_range(start_date, end_date)
      versions = all
      if start_date.present?
        versions = versions.after_date(Time.zone.parse(start_date)) 
      end
      if end_date.present?
        versions = versions.before_date(Time.zone.parse(end_date))
      end
      versions
    end

    def self.fg_film_movements_to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << %w(Serial Formula Width Length Order User DateTime)
        all.each do |v|
          csv << [v.after.serial, v.reify.formula, v.after.width, v.after.length, v.after.sales_order_code, v.created_at]
        end
      end
    end
  end
end
