module ProductsHelper

  def breadcrumb_product_page product
    link =raw category_breadcrumb product.categories.where(leaf: true).first
    link[0] =''
    pre = raw content_tag(:span, I18n.t('breadcrumb.you_are_here') + ": ")
    container = content_tag(:div, class: 'breadcrumb') do 
      pre+link
    end
    return container
  end

  def category_breadcrumb category
    if category.blank?
      link = link_to I18n.t('link.home'), root_path
      prefix = ''
    else
      link = link_to category.name, category_path(assigned_locale, category.slug)
      prefix = category_breadcrumb category.category
    end
    return prefix + '/' + link
  end

  def favorite(product_id)
    favorite_cache[product_id] if favorite_cache[product_id].present? 
    if favorites[product_id].present?
      favorite_cache[product_id] = "likeon"
    else
      favorite_cache[product_id] = ''
    end
    favorite_cache[product_id]
  end


  def favorites
    @favs ||= load_favorite
  end

  def load_favorite
    favs = {}
    fav = Favorite.none
    if current_user.present?
      fav = current_user.favorites
    else
      fav = Favorite.where(cookie_store: cookie_store)
    end
    fav.each {|f| favs[f.product_id] = 'active'}
    return favs
  end


  def favorite_cache
    @favorite_cache ||= {}
  end
end
