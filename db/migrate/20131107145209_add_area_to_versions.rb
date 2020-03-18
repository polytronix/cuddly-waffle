class AddAreaToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :area, :decimal
  end
end
