class AddTemperatureAndHumidityToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :temperature, :decimal
    add_column :master_films, :humidity, :decimal
  end
end
