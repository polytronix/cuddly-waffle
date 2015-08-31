class JobDate < ActiveRecord::Base
  STEPS = %w(released YR WR fill ET PLZ mask BE QC due).freeze
  FE_DISPLAY_STEPS = %w(YR WR fill ET SM).freeze
  BE_DISPLAY_STEPS = %w(mask PLZ BE QC FG).freeze
  DATE_TYPES = %w(planned actual).freeze

  extend SimpleCalendar
  has_calendar attribute: :value

  belongs_to :job_order

  delegate :part_number, :quantity, :serial, :run_number, to: :job_order

  validates :job_order, presence: true
  validates :step, inclusion: { in: STEPS }
  validates :date_type, inclusion: { in: DATE_TYPES }
  validates :value, presence: true
  validates_uniqueness_of :job_order_id, scope: [:step, :date_type]

  def display_step
    if step == "due" && job_order.supermarket?
      "SM"
    elsif step == "due"
      "FG"
    else
      step
    end
  end
end
