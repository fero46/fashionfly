# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[4.2]
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.binary :value, limit: 10.megabyte

      t.timestamps null: false
    end
    add_index :feeds, :user_id
  end
end
