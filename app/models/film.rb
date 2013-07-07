class Film < ActiveRecord::Base
  attr_accessible :destination, :width, :length, :custom_width, :custom_length, :reserved_for, :note, :sales_order_code, :customer, :shelf, :master_film_attributes, :splits

  belongs_to :master_film
  delegate :formula, :mix_mass, :film_code, :thinky_code, :machine_code, 
           :chemist_name, :operator_name, :effective_width, :effective_length, 
           :effective_area, :defect_count, to: :master_film

  accepts_nested_attributes_for :master_film

  before_create :set_division

  validates :phase, presence: true
  validates :master_film_id, presence: true
  validates :width, :length, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

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

  def destination=(destination)
    self.phase = destination if destination.present?
  end

  def serial
    master_film.serial + "-" + division.to_s
  end

  def master_serial
    master_film.serial
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

  def split(count)
    splits = []
    count.times do 
      splits << master_film.films.build
    end
    splits
  end

  def sibling_films
    Film.where(master_film_id: master_film_id)
  end

  def set_division
    self.division ||= sibling_films.count + 1
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      record = Film.new(row.to_hash, without_protection: true)
      record.save!(validate: false)
    end
  end
end
