class AddScopeToProducts < ActiveRecord::Migration[4.2]
  def change
    add_reference :products, :scope, index: true
  end
end
