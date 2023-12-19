# frozen_string_literal: true

class AddFavoriteToShops < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :favorite, :boolean
    add_index :shops, :favorite
  end
end
