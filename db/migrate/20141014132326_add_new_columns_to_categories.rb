# frozen_string_literal: true

class AddNewColumnsToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :published, :boolean, default: false
    add_index :categories, :published
  end
end
