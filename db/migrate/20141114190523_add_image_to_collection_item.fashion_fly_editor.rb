# This migration comes from fashion_fly_editor (originally 20141114114751)
class AddImageToCollectionItem < ActiveRecord::Migration[4.2]
  def change
    add_column :fashion_fly_editor_collection_items, :image, :string
  end
end
