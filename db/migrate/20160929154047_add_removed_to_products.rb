class AddRemovedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :removed, :boolean, default: false
    add_index :products, :removed
  end
end
