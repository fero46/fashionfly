class AddPublishedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :published, :boolean, default: false 
    add_index :products, :published
  end
end
