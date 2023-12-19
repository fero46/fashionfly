# frozen_string_literal: true

class AddSlugToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :slug, :string, after: :role
    add_index :users, :slug
  end
end
