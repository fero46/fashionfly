# frozen_string_literal: true

class CreateAverageCaches < ActiveRecord::Migration[4.2]
  def self.up
    create_table :average_caches do |t|
      t.belongs_to :rater
      t.belongs_to :rateable, polymorphic: true
      t.float :avg, null: false
      t.timestamps
    end
  end

  def self.down
    drop_table :average_caches
  end
end
