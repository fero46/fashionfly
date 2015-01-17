class CreateTableBrandsCategories < ActiveRecord::Migration
  def change
    create_table :brands_categories do |t|
      t.belongs_to :brand, index: true
      t.belongs_to :category, index: true
    end
    add_index :brands_categories, [ :brand_id, :category_id ], :unique => true, :name => 'by_brand_category'
  end
end
