class RemoveOldPhase < ActiveRecord::Migration[5.1]
  def change
    remove_column :films, :old_phase
  end
end
