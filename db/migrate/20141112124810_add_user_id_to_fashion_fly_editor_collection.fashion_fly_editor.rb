# This migration comes from fashion_fly_editor (originally 20141112115507)
class AddUserIdToFashionFlyEditorCollection < ActiveRecord::Migration[4.2]
  def change
    add_column :fashion_fly_editor_collections, :user_id, :integer
    add_index :fashion_fly_editor_collections, :user_id
  end
end
