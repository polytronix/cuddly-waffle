class AddYieldMultiplierToTenants < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :yield_multiplier, :decimal, null: false, default: 1
  end
end
