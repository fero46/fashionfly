class CreateWords < ActiveRecord::Migration[4.2]
  def change
    create_table :words do |t|
      t.integer :scope_id
      t.string :value
      t.string :type
    end
    add_index :words, :scope_id
    add_index :words, :type
  end
end
