# This migration comes from fashion_fly_editor (originally 20141125001846)
class AddScaleXAndScaleYToFashionFlyEditorCollectionItems < ActiveRecord::Migration
  def change
    add_column :fashion_fly_editor_collection_items, :scale_x, :integer
    add_column :fashion_fly_editor_collection_items, :scale_y, :integer
  end
end
