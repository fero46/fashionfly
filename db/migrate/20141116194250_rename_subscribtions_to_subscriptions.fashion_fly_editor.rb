# frozen_string_literal: true

# This migration comes from fashion_fly_editor (originally 20141116193428)
class RenameSubscribtionsToSubscriptions < ActiveRecord::Migration[4.2]
  def up
    rename_table :fashion_fly_editor_subscribtions, :fashion_fly_editor_subscriptions
  end

  def down
    rename_table :fashion_fly_editor_subscriptions, :fashion_fly_editor_subscribtions
  end
end
