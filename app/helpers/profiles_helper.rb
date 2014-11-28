module ProfilesHelper

  def user_profile user
    if user.present?
      profile_path(assigned_locale, user.slug)
    else
      "#"
    end
  end

  def profile_edit user
    if current_user && current_user.id == user.id
      link_to(t('action.edit', entity: User.model_name.human),
                       edit_profile_path(assigned_locale, user.slug),
                       class: 'edit_button')
    end
  end

  def user_name user
    if user.present?
      user.name
    else  
      t('activerecord.attributes.user.unknown')
    end
  end


  def user_image user, version
    if user.present?
      user.avatar.try(version)
    else
      "/fallback/avatar/#{version.to_s}_default.png"
    end
  end
end
