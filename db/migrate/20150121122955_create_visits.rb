class CreateVisits < ActiveRecord::Migration[4.2]
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.string :cookie
      t.integer :visitable_id
      t.string :visitable_type
      t.timestamps null: false
    end
    add_index :visits, :user_id
    add_index :visits, :cookie
    add_index :visits, [:user_id, :cookie, :visitable_id, :visitable_type], unique: true, name: :visitings
    add_index :visits, [:visitable_id, :visitable_type]
  end
end
