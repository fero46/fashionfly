class AddDirtyToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :dirty, :boolean, default: false 
    add_index :products, :dirty
  end
end
