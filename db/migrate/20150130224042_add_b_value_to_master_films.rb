class AddBValueToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :b_value, :decimal
  end
end
