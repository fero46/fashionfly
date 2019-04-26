class AddSocialLinksToScopes < ActiveRecord::Migration[4.2]
  def change
    add_column :scopes, :facebook, :string
    add_column :scopes, :twitter, :string
    add_column :scopes, :google, :string
    add_column :scopes, :pinterest, :string
    add_column :scopes, :instagram, :string
    add_column :scopes, :youtube, :string
  end
end
