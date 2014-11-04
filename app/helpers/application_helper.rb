module ApplicationHelper
  
  def like_url
    require 'uri'
    URI.escape("http://crocodealia.de/")
  end

  def scope
    if params[:locale]
      (@scope ||= Scope.where(locale: locale).first)
    else
      get_right_scope
    end
  end

  def create_categories category_group
    if category_group.present?
      category_group.categories
    else
      Category.where(main_taxon: true)
    end
  end

  def scoped_root_path
    if assigned_locale.present?
      root_path(locale: assigned_locale)
    else
      "/"
    end
  end
end
