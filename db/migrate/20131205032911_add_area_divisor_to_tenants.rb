class AddAreaDivisorToTenants < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :area_divisor, :decimal, null: false, default: 144
  end
end
