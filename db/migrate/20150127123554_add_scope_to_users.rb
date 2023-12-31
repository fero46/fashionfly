# frozen_string_literal: true

class AddScopeToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :scope_id, :integer
    add_index :users, :scope_id
    scope = Scope.first
    User.update_all(scope_id: scope.id) unless scope.nil?
  end
end
