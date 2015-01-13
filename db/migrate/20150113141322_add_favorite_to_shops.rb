class AddFavoriteToShops < ActiveRecord::Migration
  def change
    add_column :shops, :favorite, :boolean
    add_index :shops, :favorite
  end
end
