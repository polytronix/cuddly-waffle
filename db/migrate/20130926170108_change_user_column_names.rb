class ChangeUserColumnNames < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.rename :email, :username
      t.rename :name, :full_name
    end
  end
end
