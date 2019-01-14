class AddMachineIdToMasterFilm < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :machine_id, :integer
  end
end
