# This migration comes from fashion_fly_editor (originally 20141009153552)
class RenameCollectionItemAttributes < ActiveRecord::Migration
  def change
    rename_column :fashion_fly_editor_collection_items, :x_coordinate, :position_x
    rename_column :fashion_fly_editor_collection_items, :y_coordinate, :position_y
    rename_column :fashion_fly_editor_collection_items, :scale_x, :width
    rename_column :fashion_fly_editor_collection_items, :scale_y, :height
  end
end
