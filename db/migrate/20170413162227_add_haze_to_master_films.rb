class AddHazeToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :haze, :decimal
  end
end
