# frozen_string_literal: true

class AddStartToAffiliates < ActiveRecord::Migration[4.2]
  def change
    add_column :affiliates, :start_from_id, :integer, default: 0
  end
end
