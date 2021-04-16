class AddPhaseChangeToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :phase_change, :string, array: true
  end
end
