class AddMasterFilmIdToFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :master_film_id, :integer
  end
end
