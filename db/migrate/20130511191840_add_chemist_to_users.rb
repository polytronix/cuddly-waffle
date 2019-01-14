class AddChemistToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :chemist, :boolean, default: false
  end
end
