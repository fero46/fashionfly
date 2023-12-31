# frozen_string_literal: true

# This migration comes from lit (originally 20121103174049)
class CreateLitLocalizationKeys < ActiveRecord::Migration[4.2]
  def change
    create_table :lit_localization_keys do |t|
      t.string :localization_key

      t.timestamps
    end
    add_index :lit_localization_keys, :localization_key, unique: true
  end
end
