class AddMetaToScopes < ActiveRecord::Migration
  def change
    add_column :scopes, :meta_keywords, :string
    add_column :scopes, :meta_description, :text
  end
end
