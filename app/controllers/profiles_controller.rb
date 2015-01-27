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

  def email_edit
    @user = current_user
    @user.confirm_email
    if @user.update!(email_attributes)
      @mail_send = true
    end
    @show_form = true
    render :template => "welcome/index"
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

  def email_attributes
    params.require(:user).permit(:email,
                                :email_confirmation,
                                :scope_id)
  end

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
