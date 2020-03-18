class CreatePhaseSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :phase_snapshots do |t|
      t.string :phase
      t.integer :count
      t.decimal :total_area

      t.timestamps
    end
  end
end
