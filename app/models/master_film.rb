class MasterFilm < ActiveRecord::Base
  include Importable

  DEFECT_TYPES = ['Air Bubble', 'Clear Spot', 'Dent', 'Dust/Dirt', 'Edge Delam', 'Non-Uniform', 'ROM', 'Wavy', 'Clear edges', 'BBL', 'Pickle', 'Short', 'White Spot', 'Spacer Spot', 'Clear Area', 'Dropper Mark', 'Foamy Streak', 'Streak', 'Thick Spot', 'Thick Material', 'Bend', 'Blocker Mark', 'BWS', 'Spacer Cluster', 'Glue Impression', 'Brown line', 'Scratch', 'Clear Peak', 'Material Traces', 'Small Clear']

  attr_accessible :serial, :effective_width, :effective_length, :formula, :mix_mass, :film_code, :machine_id, :thinky_code, :chemist, :operator, :note, :defects

  has_many :films
  belongs_to :machine

  before_validation :upcase_attributes

  delegate :code, to: :machine, prefix: true, allow_nil: true

  validates :serial, presence: true, uniqueness: { case_sensitive: false, scope: :tenant_code },
    format: { with: /\A[A-Z]\d{4}-\d{2}\z/ }

  scope :active, -> { where(inactive: false) }
  scope :by_serial, -> { order('master_films.serial DESC') }
  scope :formula_equals, ->(formula) { where(formula: formula) }

  def save_and_create_child(user)
    if save
      film = films.build(serial: "#{serial}-1", area: 0, tenant_code: tenant_code, division: 1, phase: "lamination")
      film.save!
      dimensions = film.dimensions.build(width: 0, length: 0)
      dimensions.save!
      movement = film.film_movements.build(from_phase: "raw", to_phase: "lamination", actor: user.full_name, tenant_code: tenant_code)
      movement.save!
    end
  end

  def yield
    (100*tenant.yield_multiplier*(effective_area/mix_mass)/machine.yield_constant) if effective_area && mix_mass && machine
  end

  def effective_area
    AreaCalculator.calculate(effective_width, effective_length, tenant.area_divisor)
  end

  def laminated_at
    year = serial[0].ord + 1943
    month = serial[1,2].to_i
    day = serial[3,2].to_i
    DateTime.new(year, month, day)
  end

  def defect_count(type)
    defects[type].to_i
  end
  
  def upcase_attributes
    formula.upcase! if formula.present?
    film_code.upcase! if film_code.present?
    thinky_code.upcase! if thinky_code.present?
    serial.upcase! if serial.present?
  end

  def defects_sum
    defects.values.map(&:to_i).sum
  end

  def self.serial_range(start_serial, end_serial)
    master_films = all
    if start_serial.present?
      master_films = master_films.where("master_films.serial >= ?", start_serial)
    end
    if end_serial.present?
      master_films = master_films.where("master_films.serial <= ?", end_serial)
    end
    master_films
  end

  def self.defect_types
    types = all.inject([]) do |arry, mf|
      arry + mf.defects.keys
    end
    types.uniq
  end

  def tenant
    @tenant ||= Tenant.new(tenant_code)
  end

  def next_division
    films.pluck(:serial).map { |s| s[/.+-.+-(\d+)/, 1].to_i }.max + 1
  end

  def no_active_films?
    films.active.empty?
  end

  def set_inactive(inactive)
    self.inactive = inactive
    save!
  end
end
