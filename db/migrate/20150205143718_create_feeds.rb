class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.binary :value, :limit => 10.megabyte

      t.timestamps null: false
    end
    add_index :feeds, :user_id
  end
end
