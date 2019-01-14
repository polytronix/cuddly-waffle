class RemoveDateTypeFromJobOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_dates, :date_type
  end
end
