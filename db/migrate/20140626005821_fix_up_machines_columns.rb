class FixUpMachinesColumns < ActiveRecord::Migration[5.1]
  def change
    change_column :machines, :yield_constant, :decimal, null: false
  end
end
