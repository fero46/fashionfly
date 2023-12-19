# frozen_string_literal: true

class AddLanguageToScopes < ActiveRecord::Migration[4.2]
  def change
    add_column :scopes, :language, :string, after: :locale
    add_column :scopes, :region_code, :string, after: :language
  end
end
