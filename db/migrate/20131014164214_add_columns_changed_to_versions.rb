class AddColumnsChangedToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :columns_changed, :string, array: true
  end
end
