# frozen_string_literal: true

class AddVisitsToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :visits_count, :integer, default: 0
  end
end
