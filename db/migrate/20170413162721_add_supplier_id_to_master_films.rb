class AddSupplierIdToMasterFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :master_films, :Supplier_ID, :string
    add_column :master_films, :string, :string
  end
end
