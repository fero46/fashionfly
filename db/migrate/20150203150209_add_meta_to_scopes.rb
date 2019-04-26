class AddMetaToScopes < ActiveRecord::Migration[4.2]
  def change
    add_column :scopes, :meta_keywords, :string
    add_column :scopes, :meta_description, :text
  end
end
