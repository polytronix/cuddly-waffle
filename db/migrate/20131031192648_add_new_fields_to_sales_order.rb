class AddNewFieldsToSalesOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :sales_orders, :release_date, :date
    add_column :sales_orders, :ship_to, :string
  end
end
