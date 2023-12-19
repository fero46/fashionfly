# frozen_string_literal: true

class CreateSynonymsWords < ActiveRecord::Migration[4.2]
  def change
    create_table :synonyms_words do |t|
      t.integer :synonym_id
      t.integer :word_id
    end
    add_index :synonyms_words, :synonym_id
    add_index :synonyms_words, :word_id
  end
end
