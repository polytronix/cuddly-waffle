class AddDefectsCountSumToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :defects_sum, :integer, default: 0, null: false
  end
end
