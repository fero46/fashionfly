# frozen_string_literal: true

class AddColumnsToContests < ActiveRecord::Migration[4.2]
  def change
    add_column :contests, :startdate, :date
    add_index :contests, :startdate
    add_column :contests, :enddate, :date
    add_index :contests, :enddate
  end
end
