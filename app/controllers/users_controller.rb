class UsersController < ScopeController
  def show
    @user = User.new
  end
end