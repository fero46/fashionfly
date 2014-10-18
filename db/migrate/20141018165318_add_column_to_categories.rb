class AddColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :leaf, :boolean
    add_index :categories, :leaf
  end
end
