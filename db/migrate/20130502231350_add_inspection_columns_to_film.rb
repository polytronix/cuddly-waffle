class AddInspectionColumnsToFilm < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :reserved_for, :text
    add_column :films, :note, :text
  end
end
