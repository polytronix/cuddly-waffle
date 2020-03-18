class AddFilmCodeToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :film_code, :string
  end
end
