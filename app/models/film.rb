class Film < ActiveRecord::Base
  include PgSearch
  include Importable

  attr_accessible :note, :shelf, :phase, :deleted, :sales_order_id, :order_fill_count, :master_film_id, :tenant_code, :serial, :dimensions_attributes
  attr_reader :destination

  belongs_to :master_film
  belongs_to :sales_order
  has_many :film_movements
  has_many :dimensions, -> { order('id ASC') }

  accepts_nested_attributes_for :dimensions, allow_destroy: true, reject_if: proc { |attributes| attributes['width'].blank? || attributes['length'].blank? }

  delegate :formula, to: :master_film
  delegate :code, to: :sales_order, prefix: true, allow_nil: true
  delegate :width, :length, :area, to: :primary_dimension, allow_nil: true

  before_save :upcase_shelf

  validates :phase, presence: true
  validates :order_fill_count, numericality: { greater_than: 0 }
  validate :must_have_dimensions, on: :update

  scope :with_dimensions, -> { joins('LEFT OUTER JOIN dimensions ON dimensions.film_id = films.id').uniq.preload(:dimensions) }
  scope :active, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }
  scope :phase, ->(phase) { where(phase: phase) }
  scope :large, ->(cutoff) { with_dimensions.merge(Dimension.large(cutoff)) }
  scope :small, ->(cutoff) { with_dimensions.merge(Dimension.small(cutoff)) }
  scope :reserved, -> { where("sales_order_id IS NOT NULL") }
  scope :not_reserved, -> { where("sales_order_id IS NULL") }

  pg_search_scope :search, 
    against: [:serial, :note, :shelf, :phase], 
    using: { tsearch: { prefix: true } },
    associated_against: { master_film: [:formula], sales_order: [:code] }

  def split
    split = master_film.films.build(serial: "#{master_film.serial}-#{master_film.next_division}", tenant_code: tenant_code, phase: phase).tap(&:save!)
    dimensions = split.dimensions.build(width: width, length: length)
    dimensions.save!
    split
  end

  def update_and_move(attrs, destination, user)
    before_phase = phase
    if update_attributes(attrs)
      if PhaseDefinitions.front_end?(before_phase)
        master_film.effective_width = attrs[:width]
        master_film.effective_length = attrs[:length]
        master_film.save!
      end
      move_to(destination, user) if destination.present?
    end
  end

  def unassign
    reset_sales_order
    save!
  end


  def move_to(destination, user)
    reset_sales_order unless %w(stock wip fg).include?(destination)
    self.phase = destination
    movement = film_movements.build(from_phase: phase_was, to_phase: destination, width: width, length: length, actor: user.full_name, tenant_code: tenant_code)
    save!
    movement.save!
  end

  def tenant
    @tenant ||= Tenant.new(tenant_code)
  end

  private
  
  def upcase_shelf
    shelf.upcase! if shelf.present?
  end

  def reset_sales_order
    assign_attributes(sales_order_id: nil, order_fill_count: 1)
  end

  def primary_dimension
    @dimension ||= dimensions.first
  end

  def must_have_dimensions
    if dimensions.empty? or dimensions.all? {|dimension| dimension.marked_for_destruction? }
      errors.add(:base, 'Must have dimensions')
    end
  end
end
