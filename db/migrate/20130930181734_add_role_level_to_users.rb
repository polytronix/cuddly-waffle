class AddRoleLevelToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role_level, :integer, default: 0
  end
end
