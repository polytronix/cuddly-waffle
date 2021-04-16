class AddOperatorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :operator, :boolean, default: false
  end
end
