class RemoveDimensionsFromFilms < ActiveRecord::Migration[5.1]
  def change
    remove_column :films, :width
    remove_column :films, :length
  end
end
