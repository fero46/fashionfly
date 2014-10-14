class AddNewColumnsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :published, :boolean, default: false 
    add_index :categories, :published
  end
end
