# frozen_string_literal: true

class AddColumToAffiliate < ActiveRecord::Migration[4.2]
  def change
    add_column :affiliates, :importing, :boolean, default: false
    add_column :affiliates, :percent, :integer, default: 0

    add_index :affiliates, :importing
  end
end
