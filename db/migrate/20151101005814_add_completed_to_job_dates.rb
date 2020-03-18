class AddCompletedToJobDates < ActiveRecord::Migration[5.1]
  def change
    add_column :job_dates, :completed, :boolean, null: false, default: false
  end
end
