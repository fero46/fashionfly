class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :scope_id
      ['shop', 'collection', 'category'].each do |x|
        t.string  "#{x}_highlight_title".to_s
        t.string  "#{x}_highlight_image".to_s
        t.text "#{x}_highlight_link".to_s
      end
      t.boolean :show_new_startpage
      t.timestamps null: false
    end
    add_index :properties, :scope_id, unique: true
  end
end
