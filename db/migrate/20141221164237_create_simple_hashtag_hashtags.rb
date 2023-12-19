# frozen_string_literal: true

# This migration comes from simple_hashtag
class CreateSimpleHashtagHashtags < ActiveRecord::Migration[4.2]
  def change
    create_table :simple_hashtag_hashtags do |t|
      t.string :name, index: true
      t.string :scope_id, index: true
      t.timestamps
    end
    add_index :simple_hashtag_hashtags, %i[name scope_id], unique: true
  end
end
