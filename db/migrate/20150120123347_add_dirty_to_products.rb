class AddDirtyToProducts < ActiveRecord::Migration
  def change
    add_column :products, :dirty, :boolean, default: false 
    add_index :products, :dirty
  end
end
