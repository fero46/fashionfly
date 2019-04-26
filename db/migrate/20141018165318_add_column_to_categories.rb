class AddColumnToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :leaf, :boolean
    add_index :categories, :leaf
  end
end
