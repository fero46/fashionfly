# This migration comes from fashion_fly_editor (originally 20141112112419)
class CreateFashionFlyEditorCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :fashion_fly_editor_categories do |t|
      t.string :name
      t.string :slug
      t.integer :parent_id
      t.string :parent_type
      t.timestamps
    end
    add_index :fashion_fly_editor_categories, :slug, unique: true 
    add_index :fashion_fly_editor_categories, [:parent_id, :parent_type], name: :category_parent
  end
end
