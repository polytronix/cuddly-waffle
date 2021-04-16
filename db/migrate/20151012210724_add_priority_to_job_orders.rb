class AddPriorityToJobOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :job_orders, :priority, :string, null: false, default: ""
  end
end
