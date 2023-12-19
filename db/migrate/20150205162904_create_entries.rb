# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :url
      t.date :published
      t.string :author
      t.string :entry_identifier
      t.text :summary
      t.binary :content, limit: 10.megabyte
      t.integer :scope_id
      t.integer :user_id
      t.integer :feed_id
      t.timestamps null: false
    end
    add_index :entries, :published
    add_index :entries, :scope_id
    add_index :entries, :feed_id
    add_index :entries, :user_id
  end
end
