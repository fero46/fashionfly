# frozen_string_literal: true

class AddColumnsToFashionFlyEditorCollections < ActiveRecord::Migration[4.2]
  def change
    add_column  :fashion_fly_editor_collections, :actual_trend, :integer
    add_index   :fashion_fly_editor_collections, :actual_trend
    add_column  :fashion_fly_editor_collections, :last_trend, :integer
    add_column  :fashion_fly_editor_collections, :favorites_count, :integer
    add_index   :fashion_fly_editor_collections, :favorites_count
  end
end
