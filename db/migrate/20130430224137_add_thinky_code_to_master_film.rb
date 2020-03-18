class AddThinkyCodeToMasterFilm < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :thinky_code, :string
  end
end
