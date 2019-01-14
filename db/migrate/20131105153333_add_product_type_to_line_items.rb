class AddProductTypeToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :product_type, :string
  end
end
