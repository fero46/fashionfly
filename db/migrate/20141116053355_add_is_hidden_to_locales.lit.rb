# frozen_string_literal: true

# This migration comes from lit (originally 20130511111904)
class AddIsHiddenToLocales < ActiveRecord::Migration[4.2]
  def change
    add_column :lit_locales, :is_hidden, :boolean, default: false
  end
end
