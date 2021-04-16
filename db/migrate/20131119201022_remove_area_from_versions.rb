class RemoveAreaFromVersions < ActiveRecord::Migration[5.1]
  def change
    remove_column :versions, :area, :decimal
  end
end
