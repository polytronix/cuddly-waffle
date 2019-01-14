class AddSalesOrderIdToFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :sales_order_id, :integer
  end
end
