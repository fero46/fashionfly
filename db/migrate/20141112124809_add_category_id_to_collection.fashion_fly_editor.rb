# frozen_string_literal: true

# This migration comes from fashion_fly_editor (originally 20141112115157)
class AddCategoryIdToCollection < ActiveRecord::Migration[4.2]
  def change
    add_column :fashion_fly_editor_collections, :category_id, :integer
    add_index :fashion_fly_editor_collections, :category_id
  end
end
