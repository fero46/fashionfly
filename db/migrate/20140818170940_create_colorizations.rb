class CreateColorizations < ActiveRecord::Migration
  def change
    create_table :colorizations do |t|
      t.string :name
    end
    add_index :colorizations, :name
  end
end
