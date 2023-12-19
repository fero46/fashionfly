# frozen_string_literal: true

class AddCounterCacheToProducts < ActiveRecord::Migration[4.2]
  def up
    add_column :products, :favorites_count, :integer, default: 0
    add_index :products, :favorites_count
    Product.reset_column_information
    Product.all.each do |p|
      Product.update_counters p.id, favorites_count: p.favorites.length
    end
  end

  def down
    remove_column :projects, :favorites_count
  end
end
