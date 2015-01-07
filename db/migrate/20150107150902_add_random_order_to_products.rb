class AddRandomOrderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :random_order, :integer, default: 0
    add_index :products, :random_order
  end
end
