class AddTimeZoneToTenants < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :time_zone, :string
  end
end
