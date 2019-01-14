class CreateMachinesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :machines do |t|
      t.string :code

      t.timestamps
    end
  end
end
