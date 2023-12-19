# frozen_string_literal: true

# This migration comes from lit (originally 20130923162141)
class CreateLitSources < ActiveRecord::Migration[4.2]
  def change
    create_table :lit_sources do |t|
      t.string :identifier
      t.string :url
      t.string :api_key
      t.datetime :last_updated_at

      t.timestamps
    end
  end
end
