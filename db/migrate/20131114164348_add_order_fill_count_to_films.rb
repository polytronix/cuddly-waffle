class AddOrderFillCountToFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :order_fill_count, :integer, default: 1, nil: false
  end
end
