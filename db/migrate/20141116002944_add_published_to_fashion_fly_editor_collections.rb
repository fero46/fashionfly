# frozen_string_literal: true

class AddPublishedToFashionFlyEditorCollections < ActiveRecord::Migration[4.2]
  def change
    add_column :fashion_fly_editor_collections, :published, :boolean, default: false
    add_index :fashion_fly_editor_collections, :published
  end
end
