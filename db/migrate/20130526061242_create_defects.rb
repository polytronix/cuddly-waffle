class CreateDefects < ActiveRecord::Migration[5.1]
  def change
    create_table :defects do |t|
      t.string :defect_type
      t.integer :count
      t.integer :master_film_id

      t.timestamps
    end
  end
end
