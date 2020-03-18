class AddNoteToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :note, :text
  end
end
