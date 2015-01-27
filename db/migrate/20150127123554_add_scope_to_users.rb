class AddScopeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :scope_id, :integer
    add_index :users, :scope_id
    scope = Scope.first
    User.update_all(scope_id: scope.id)
  end
end
