class AddCancelledColumnToSalesOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :sales_orders, :cancelled, :boolean, default: false
  end
end
