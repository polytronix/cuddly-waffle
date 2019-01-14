class AddAreaAfterToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :area_after, :decimal, default: 0, null: false
  end
end
