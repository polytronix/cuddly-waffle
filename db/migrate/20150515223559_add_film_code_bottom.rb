class AddFilmCodeBottom < ActiveRecord::Migration[5.1]
  def change
    rename_column :master_films, :film_code, :film_code_top
    add_column :master_films, :film_code_bottom, :string
  end
end
