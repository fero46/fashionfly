# This migration comes from fashion_fly_editor (originally 20141216191601)
class AddDimensionToFashionFlyEditorCollections < ActiveRecord::Migration[4.2]
  def change
    add_column :fashion_fly_editor_collections, :height, :integer
    add_column :fashion_fly_editor_collections, :width, :integer
  end
end
