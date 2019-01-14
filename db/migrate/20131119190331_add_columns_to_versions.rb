class AddColumnsToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :area_change, :decimal, array: true
    add_column :versions, :split_id, :integer
  end
end
