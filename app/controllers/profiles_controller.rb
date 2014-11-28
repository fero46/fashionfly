class ProfilesController < ScopeController

  before_action :authenticate_user!, except: :show

  def show
    @user = User.where(slug: params[:id]).first
  end

  def edit
    @user = current_user
  end

  def design
    @user = current_user

  end

  def update
    @user = current_user
    if @user.update(user_attributes)
      redirect_to profile_path(assigned_locale, @user.slug)
    else
      render formular
    end
  end

protected 

  def user_attributes
    params.require(:user).permit(:banner,
                                 :avatar,
                                 :remove_avatar,
                                 :info,
                                 :name)
  end

  def formular
    if params[:formular] == 'profile'
      'new'
    elsif params[:formular] == 'design'
      'design'
    else
      'new'
    end
  end

end
