class AddRandomOrderToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :random_order, :integer, default: 0
    add_index :products, :random_order
  end
end
