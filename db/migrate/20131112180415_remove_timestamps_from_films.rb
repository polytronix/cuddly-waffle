class RemoveTimestampsFromFilms < ActiveRecord::Migration[5.1]
  def change
    remove_column :films, :created_at, :datetime
    remove_column :films, :updated_at, :datetime
  end
end
