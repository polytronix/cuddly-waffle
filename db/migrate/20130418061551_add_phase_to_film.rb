class AddPhaseToFilm < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :phase, :string
  end
end
