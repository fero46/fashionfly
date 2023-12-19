# frozen_string_literal: true

class CreateContests < ActiveRecord::Migration[4.2]
  def change
    create_table :contests do |t|
      t.string :title
      t.string :banner
      t.string :slug
      t.text :body
      t.references :scope, index: true
      t.boolean :finished
      t.timestamps
    end
    add_index :contests, :finished
    add_index :contests, :slug
  end
end
