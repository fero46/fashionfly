module ApplicationHelper
  def like_url
    require 'uri'
    URI.escape("http://crocodealia.de/")
  end

  def scope
    (@scope ||= Scope.where(locale: locale).first) if params[:locale]
  end

  def create_categories category_group
    if category_group.present?
      category_group.categories
    else
      Category.where(main_taxon: true)
    end
  end
end
