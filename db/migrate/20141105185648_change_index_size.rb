# frozen_string_literal: true

class ChangeIndexSize < ActiveRecord::Migration[4.2]
  def up
    remove_index :scopes, :locale
    add_index :scopes, :locale, length: 10
    remove_index :scopes, :country_code
    add_index :scopes, :country_code, length: 10
    remove_index :favorites, :cookie_store
    add_index :favorites, :cookie_store, length: 30
    remove_index :categories, :slug
    add_index :categories, :slug, unique: true
  end

  def down
    remove_index :scopes, :locale
    add_index :scopes, :locale
    remove_index :scopes, :country_code
    add_index :scopes, :country_code
    remove_index :favorites, :cookie_store
    add_index :favorites, :cookie_store
    remove_index :categories, :slug
    add_index :categories, :slug
  end
end
