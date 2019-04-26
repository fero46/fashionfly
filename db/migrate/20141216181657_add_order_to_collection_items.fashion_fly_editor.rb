# This migration comes from fashion_fly_editor (originally 20141216174802)
class AddOrderToCollectionItems < ActiveRecord::Migration[4.2]
  def change
    add_column :fashion_fly_editor_collection_items, :order, :integer, default: 0
  end
end
