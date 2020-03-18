class AddDueDateToSalesOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :sales_orders, :due_date, :date
  end
end
