class AddWipColumnsToFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :customer, :string
    add_column :films, :sales_order_code, :string
    add_column :films, :custom_width, :decimal
    add_column :films, :custom_length, :decimal
  end
end
