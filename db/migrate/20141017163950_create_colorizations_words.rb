class CreateColorizationsWords < ActiveRecord::Migration[4.2]
  def change
    create_table :colorizations_words do |t|
      t.integer :colorization_id
      t.integer :word_id
    end
    add_index :colorizations_words, :colorization_id
    add_index :colorizations_words, :word_id
  end
end
