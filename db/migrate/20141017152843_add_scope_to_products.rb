class AddScopeToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :scope, index: true
  end
end
