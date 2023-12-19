# frozen_string_literal: true

class AddExtreaFieldToAffiliates < ActiveRecord::Migration[4.2]
  def change
    add_column :affiliates, :replace_only_images, :boolean, default: false
  end
end
