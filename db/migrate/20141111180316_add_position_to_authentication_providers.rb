# frozen_string_literal: true

class AddPositionToAuthenticationProviders < ActiveRecord::Migration[4.2]
  def up
    add_column :authentication_providers, :position, :integer, default: 0
    add_index :authentication_providers, :position
    AuthenticationProvider.reset_column_information

    list = %w[facebook tumblr twitter google_oauth2]

    list.each_with_index do |provider, index|
      auth = AuthenticationProvider.where(name: provider).first
      auth.position = index + 1 if auth.present?
      auth.save if auth.present?
    end
  end

  def down
    remove_columns :authentication_providers, :position
  end
end
