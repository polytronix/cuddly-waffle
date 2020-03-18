class AddDeletedToFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :deleted, :boolean, default: false
  end
end
