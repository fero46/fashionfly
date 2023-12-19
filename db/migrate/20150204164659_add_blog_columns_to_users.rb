# frozen_string_literal: true

class AddBlogColumnsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :blog_status, :string, default: 'NONE'
    add_column :users, :is_blogger, :boolean, default: false
    add_column :users, :blog_title, :string
    add_column :users, :blog_feed, :text
    add_column :users, :blog_url, :string
    add_index :users, :is_blogger
  end
end
