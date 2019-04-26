class AddSalesToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :sale_price, :decimal, :precision => 10, :scale => 2
    add_column :products, :sale, :boolean, default: false
    add_index :products, :sale
  end
end
