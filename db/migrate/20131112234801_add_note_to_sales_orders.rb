class AddNoteToSalesOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :sales_orders, :note, :text
  end
end
