class AddCustomerToSalesOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :sales_orders, :customer, :string
  end
end
