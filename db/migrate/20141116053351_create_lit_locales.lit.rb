# This migration comes from lit (originally 20121103144612)
class CreateLitLocales < ActiveRecord::Migration
  def change
    create_table :lit_locales do |t|
      t.string :locale

      t.timestamps
    end
  end
end
