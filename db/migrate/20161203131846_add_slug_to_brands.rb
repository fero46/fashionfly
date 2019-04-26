class AddSlugToBrands < ActiveRecord::Migration[4.2]
  def change
    add_column :brands, :slug, :string
    add_index :brands, :slug
    Brand.all.each{|x| x.create_slug }
  end
end
