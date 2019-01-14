class RemoveSplitIdFromVersions < ActiveRecord::Migration[5.1]
  def change
    remove_column :versions, :split_id, :integer
  end
end
