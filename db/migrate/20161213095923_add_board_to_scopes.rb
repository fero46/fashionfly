class AddBoardToScopes < ActiveRecord::Migration[4.2]
  def change
    add_column :scopes, :board_number, :string
  end
end
