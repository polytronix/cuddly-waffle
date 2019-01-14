class AddSmallAreaCutoffToTenants < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :small_area_cutoff, :decimal, null: false, default: 16
  end
end
