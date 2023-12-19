# frozen_string_literal: true

# This migration comes from lit (originally 20121225112100)
class AddIsCompletedAndIsStarredToLocalizationKeys < ActiveRecord::Migration[4.2]
  def change
    add_column :lit_localization_keys, :is_completed, :boolean, default: false
    add_column :lit_localization_keys, :is_starred, :boolean, default: false
  end
end
