class CreateRebuilders < ActiveRecord::Migration
  def change
    create_table :rebuilders do |t|
      t.integer :collection_id, null: false
    end
    add_index :rebuilders, :collection_id, unique: true
  end
end
