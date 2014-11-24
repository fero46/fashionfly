class AddDimensionsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :width, :integer, default: 0
    add_column :products, :height, :integer, default: 0
  end
end
