class DropPhaseSnapshots < ActiveRecord::Migration[5.1]
  def change
    drop_table :phase_snapshots
  end
end
