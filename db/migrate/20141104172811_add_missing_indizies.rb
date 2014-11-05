class AddMissingIndizies < ActiveRecord::Migration
  def change
    add_index :categories, :category_id
    add_index :categorizations, :category_id 
    add_index :categorizations, :product_id
    add_index :products, [:affi_shop, :affi_code], :name => 'affi_name'
    add_index :products, :colorization_id
    add_index :products, :brand_id
    add_index :categorizations, [:category_id, :product_id]
    add_index :scopes, :locale
  end
end
