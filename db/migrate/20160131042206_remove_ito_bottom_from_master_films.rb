class RemoveItoBottomFromMasterFilms < ActiveRecord::Migration[5.1]
  def change
    remove_column :master_films, :film_code_bottom, :string
  end
end