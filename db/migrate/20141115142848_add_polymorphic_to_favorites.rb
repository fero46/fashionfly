class AddPolymorphicToFavorites < ActiveRecord::Migration[4.2]
  def change
    add_column :favorites, :object_type, :string, after: :product_id
    add_index :favorites, :object_type
    add_column :favorites, :object_id, :integer, after: :product_id
    add_index :favorites, :object_id
    add_index :favorites, [:object_id,:object_type] 
    remove_column :favorites, :product_id
  end
end
