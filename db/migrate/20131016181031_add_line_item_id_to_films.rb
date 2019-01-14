class AddLineItemIdToFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :line_item_id, :integer
  end
end
