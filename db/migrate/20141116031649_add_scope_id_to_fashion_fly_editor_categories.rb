class AddScopeIdToFashionFlyEditorCategories < ActiveRecord::Migration
  def change
    add_column :fashion_fly_editor_categories, :scope_id, :integer
    add_index :fashion_fly_editor_categories, :scope_id
  end
end
