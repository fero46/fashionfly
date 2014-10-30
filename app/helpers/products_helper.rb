module ProductsHelper

  def breadcrumb_product_page product
    link =raw category_breadcrumb product.categories.where(leaf: true).first
    link[0] =''
    pre = raw content_tag(:strong, I18n.t('breadcrumb.you_are_here') + ": ")
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
      link = link_to category.name, category_path(params[:locale], category.slug)
      prefix = category_breadcrumb category.category
    end
    return prefix + '>' + link
  end
end
