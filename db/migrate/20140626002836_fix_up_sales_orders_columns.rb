class FixUpSalesOrdersColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :sales_orders, :cancelled
  end
end
