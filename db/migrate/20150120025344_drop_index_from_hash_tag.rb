# frozen_string_literal: true

class DropIndexFromHashTag < ActiveRecord::Migration[4.2]
  def change
    remove_index :simple_hashtag_hashtags, %i[name scope_id]
    add_index :simple_hashtag_hashtags, %i[name scope_id], unique: true
  end
end
