class AddInspectorToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :inspector, :string
  end
end
