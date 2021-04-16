class AddShipDateToSalesOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :sales_orders, :ship_date, :date, default: nil
  end
end
