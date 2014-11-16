class AddPublishedToFashionFlyEditorCollections < ActiveRecord::Migration
  def change
    add_column :fashion_fly_editor_collections, :published, :boolean, default: false
    add_index :fashion_fly_editor_collections, :published
  end
end
