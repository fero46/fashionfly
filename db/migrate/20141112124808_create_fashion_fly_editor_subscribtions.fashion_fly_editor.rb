# frozen_string_literal: true

# This migration comes from fashion_fly_editor (originally 20141112113124)
class CreateFashionFlyEditorSubscribtions < ActiveRecord::Migration[4.2]
  def change
    create_table :fashion_fly_editor_subscribtions do |t|
      t.references :collection, index: true
      t.references :subscriber, polymorphic: true
      t.timestamps
    end
    add_index :fashion_fly_editor_subscribtions, %i[subscriber_id subscriber_type], name: :subscriber
  end
end
