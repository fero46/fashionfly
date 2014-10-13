class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :country_code
      t.string :locale

      t.timestamps
    end
    add_index :scopes, :country_code, unique: true
  end
end
