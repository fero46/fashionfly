class AddLanguageToScopes < ActiveRecord::Migration
  def change
    add_column :scopes, :language, :string, after: :locale
    add_column :scopes, :region_code, :string, after: :language
  end
end
