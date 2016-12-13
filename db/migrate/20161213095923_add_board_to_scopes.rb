class AddBoardToScopes < ActiveRecord::Migration
  def change
    add_column :scopes, :board_number, :string
  end
end
