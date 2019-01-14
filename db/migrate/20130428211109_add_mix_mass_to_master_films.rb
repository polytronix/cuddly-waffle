class AddMixMassToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :mix_mass, :decimal
  end
end
