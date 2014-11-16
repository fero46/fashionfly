module ProfilesHelper

  def user_profile user
    profile_path(assigned_locale, user.slug)
  end

end
