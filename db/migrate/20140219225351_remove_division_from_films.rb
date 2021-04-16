class RemoveDivisionFromFilms < ActiveRecord::Migration[5.1]
  def change
    remove_column :films, :division
  end
end
