class AddYieldConstantToMachines < ActiveRecord::Migration[5.1]
  def change
    add_column :machines, :yield_constant, :decimal
  end
end
