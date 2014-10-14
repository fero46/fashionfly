class AddScopeToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :scope, index: true
    add_column :categories, :main_taxon, :boolean
    add_index :categories, :main_taxon
    add_column :categories, :position, :integer
    add_index :categories, :position
  end
end
