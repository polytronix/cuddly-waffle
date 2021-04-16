class CreateSalesOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_orders do |t|
      t.string :code

      t.timestamps
    end
  end
end
