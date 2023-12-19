# frozen_string_literal: true

class CreateCategoriesIconsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :categories_icons do |t|
      t.integer :category_id
      t.integer :icon_id
    end
    add_index :categories_icons, :category_id
    add_index :categories_icons, :icon_id
  end
end
