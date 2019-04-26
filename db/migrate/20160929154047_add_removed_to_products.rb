class AddRemovedToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :removed, :boolean, default: false
    add_index :products, :removed
  end
end
