# This migration comes from fashion_fly_editor (originally 20140918084031)
class CreateFashionFlyEditorCollectionItems < ActiveRecord::Migration
  def change
    create_table :fashion_fly_editor_collection_items do |t|
      t.integer :collection_id
      t.integer :item_id
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.float :scale_x
      t.float :scale_y
      t.float :rotation

      t.timestamps
    end
  end
end
