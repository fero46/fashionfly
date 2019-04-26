class AddPublishedToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :published, :boolean, default: false 
    add_index :products, :published
  end
end
