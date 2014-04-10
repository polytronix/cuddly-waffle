class SalesOrder < ActiveRecord::Base
  attr_accessible :code, :customer, :ship_to, :release_date, :due_date, :ship_date, :note, :line_items_attributes, :cancelled

  has_many :line_items, dependent: :destroy
  has_many :films
  
  accepts_nested_attributes_for :line_items, allow_destroy: true
  
  validates :code, presence: true, uniqueness: { case_sensitive: false, scope: :tenant_code }

  include PgSearch
  pg_search_scope :search, against: [:code, :customer, :ship_to, :note], 
    :using => { tsearch: { prefix: true } }

  scope :by_code, -> { order('substring(code from 6 for 1) DESC, substring(code from 3 for 3) DESC') }
  scope :shipped, -> { where('ship_date is not null and cancelled = false') }
  scope :unshipped, -> { where(ship_date: nil, cancelled: false) }
  scope :cancelled, -> { where(cancelled: true) }
  scope :has_release_date, -> { where('release_date is not null') }
  scope :has_due_date, -> { where('due_date is not null') }
  scope :type, ->(prefix) { where('code ILIKE ?', prefix) if prefix.present? }

  def self.ship_date_range(start_date, end_date)
    sales_orders = shipped
    sales_orders = sales_orders.where("ship_date >= ?", start_date) if start_date.present?
    sales_orders = sales_orders.where("ship_date <= ?", end_date) if end_date.present?
    sales_orders
  end

  def self.with_ship_date(date)
    where("ship_date = ?", date)
  end

  def self.text_search(query)
    if query.present?
      #reorder is workaround for pg_search issue 88
      search(query)
    else
      all
    end
  end

  def cycle_days
    (ship_date - release_date).to_i
  end

  def cancel
    self.cancelled = true
    save!
  end

  def uncancel
    self.cancelled = false
    save!
  end

  def total_quantity
    line_items.sum(:quantity)
  end

  def total_assigned_film_count(phase = nil)
    if phase
      films.where(phase: phase).sum(:order_fill_count)
    else
      films.sum(:order_fill_count)
    end
  end

  def total_assigned_film_percent(phase)
    total_assigned_film_count(phase)*100/total_quantity
  rescue ZeroDivisionError
    0
  end

  def total_custom_area
    line_items.map{ |li| li.total_area.to_f }.sum
  end

  def total_assigned_area
    films.map{ |f| f.area.to_f }.sum
  end

  def utilization
    100*total_custom_area/total_assigned_area if total_custom_area && total_assigned_area && total_assigned_area > 0
  end

  def self.total_custom_area_by_product_type(type)
    custom_areas = all.map do |s|
      s.line_items.where(product_type: type).map{ |li| li.total_area.to_f }.sum
    end
    custom_areas.sum
  end

  def tenant
    @tenant ||= Tenant.new(tenant_code)
  end
end
