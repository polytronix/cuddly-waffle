class Film < ActiveRecord::Base
  attr_accessible :destination, :width, :length, :custom_width, :custom_length,
    :reserved_for, :note, :sales_order_code, :customer, :shelf,
    :master_film_attributes, :splits, :effective_width, :effective_length,
    :phase

  belongs_to :master_film
  has_many :film_movements

  delegate :formula, :mix_mass, :film_code, :thinky_code, :machine_code,
    :chemist_name, :operator_name, :effective_width, :effective_length,
    :effective_area, :defect_count, to: :master_film

  accepts_nested_attributes_for :master_film

  before_create :set_division

  validates :phase, presence: true

  scope :phase, lambda { |phase| where(phase: phase) }
  scope :small, where('width*length/144 < ?', 16)
  scope :large, where('width*length/144 >= ? or width IS NULL or length IS NULL', 16)
  scope :lamination, phase("lamination")
  scope :inspection, phase("inspection")
  scope :large_stock, phase("stock").large
  scope :small_stock, phase("stock").small
  scope :wip, phase("wip")
  scope :fg, phase("fg")
  scope :testing, phase("testing")
  scope :nc, phase("nc")
  scope :scrap, phase("scrap")

  def destination
  end

  def destination=(to_phase)
    if to_phase.present?
      from_phase = to_phase == "lamination" ? "raw material" : phase
      self.phase = to_phase
      movement = film_movements.build(from: from_phase, to: to_phase, area: area)
      movement.save!
    end
  end

  def effective_width=(width)
    if width.present?
      self.width = width
      master_film.effective_width = width
    end
  end

  def effective_length=(length)
    if length.present?
      self.length = length
      master_film.effective_length = length
    end
  end

  def serial
    master_film.serial + "-" + division.to_s
  end

  def area
    width * length / 144 if width && length
  end

  def custom_area
    custom_width * custom_length / 144 if custom_width && custom_length
  end

  def utilization
    custom_area / area if custom_area && area
  end

  def valid_destinations
    case phase
    when "lamination"
      ["inspection"]
    when "inspection"
      %w{stock wip testing nc}
    when "stock"
      %w{wip testing nc}
    when "wip"
      %w{fg stock testing nc}
    when "fg"
      %w{wip stock testing nc}
    when "testing"
      %w{stock nc}
    when "nc"
      %w{scrap stock testing}
    when "scrap"
      %w{stock nc testing}
    else
      []
    end
  end

  def sibling_films
    Film.where(master_film_id: master_film_id)
  end

  def sibling_count
    sibling_films.count
  end

  def set_division
    self.division ||= sibling_films.count + 1
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      record = Film.new(row.to_hash, without_protection: true)
      record.save!(validate: false)
    end
    ActiveRecord::Base.connection.execute("SELECT setval('films_id_seq',
                                          (SELECT MAX(id) FROM films));") 
  end
end
