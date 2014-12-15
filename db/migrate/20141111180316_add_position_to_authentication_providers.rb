class AddPositionToAuthenticationProviders < ActiveRecord::Migration
  def up
    add_column :authentication_providers, :position, :integer, default: 0
    add_index :authentication_providers, :position
    AuthenticationProvider.reset_column_information

    list = ['facebook', 'tumblr', 'twitter', 'google']

    list.each_with_index do |provider ,index|
      auth = AuthenticationProvider.where(name: provider).first
      auth.position = index + 1
      auth.save
    end
  end

  def down
    remove_columns :authentication_providers, :position
  end
end
