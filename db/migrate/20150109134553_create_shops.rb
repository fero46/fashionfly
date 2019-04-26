class CreateShops < ActiveRecord::Migration[4.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :logo
      t.text :link
      t.text :body
      t.text :sidebar_banner
      t.text :top_banner
      t.text :bottom_banner
      t.integer :scope_id
      t.integer :position, default: 0
      t.timestamps null: false
    end
    add_index :shops, :scope_id
    add_index :shops, :position
  end
end
