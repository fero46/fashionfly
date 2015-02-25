# This migration comes from fashion_fly_editor (originally 20150225215816)
class ChangeColumnTypeInFashionFlyEditorCollections < ActiveRecord::Migration
  def change
    change_column :fashion_fly_editor_collections, :description, :text
  end
end
