class CreateBanners < ActiveRecord::Migration[4.2]
  def change
    create_table :banners do |t|
      t.string :name
      t.string :banner
      t.text :link
      t.string :preview_ids
      t.string :previews_model
      t.integer :scope_id
      t.integer :position, default: 0
      t.timestamps null: false
    end
    add_index :banners, :scope_id
    add_index :banners, :position
  end
end
