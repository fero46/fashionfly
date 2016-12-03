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

  def breadcrumb_product_text product
    category = product.categories.where(leaf: true).first
    category_breadcrumb_text category
  end

  def category_breadcrumb_text category
    if category.blank?
      return ''
    else
      prefix = category_breadcrumb_text category.category
    end
    return (prefix.present? ? prefix + "/" : '' ) + category.name
  end

  def favorite(markable)
    markable_key = markable.class.name + markable.id.to_s
    favorite_cache[markable_key] if favorite_cache[markable_key].present?
    if favorites[markable_key].present?
      favorite_cache[markable_key] = "likeon"
    else
      favorite_cache[markable_key] = ''
    end
    favorite_cache[markable_key]
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
    fav.each {|f| favs[f.markable_type+f.markable_id.to_s] = 'active'}
    return favs
  end


  def favorite_cache
    @favorite_cache ||= {}
  end

  def product_color product
    if product.blank? || product.colorization.blank?
      t 'products.show.unknown'
    else
      t 'products.show.' + product.colorization.try(:name).gsub('#','_')
    end
  end

  def product_color_hex product
    if product.blank? || product.colorization.blank?
      'none'
    else
       product.colorization.try(:name)
    end
  end

  def product_brand product
    if product.blank? || product.brand.blank?
      t 'products.show.unknown'
    else
      product.try(:brand).try(:name)
    end
  end


end
