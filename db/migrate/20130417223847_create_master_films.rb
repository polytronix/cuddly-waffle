class CreateMasterFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :master_films do |t|
      t.string :serial
      t.string :formula

      t.timestamps
    end
  end
end
