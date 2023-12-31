# frozen_string_literal: true

module CollectionsHelper
  def breadcrumb_collection_text(collection)
    category = collection.category
    collection_category_breadcrumb_text category
  end

  def collection_category_breadcrumb_text(category)
    return '' if category.blank?

    prefix = if category.parent_type == 'Scope'
               nil
             else
               collection_category_breadcrumb_text category.parent
             end
    (prefix.present? ? "#{prefix}/" : '') + category.name
  end

  def render_embed_code(collection)
    content =  javascript_include_tag javascript_url('widget'), type: 'text/javascript'
    content << content_tag(:div, 'data' => collection.id, 'host' => request.host_with_port,
                                 'class' => 'fashionfly-widget') do
      link_to @collection.title, collection_url(assigned_locale, @collection), title: @collection.title,
                                                                               alt: @collection.title
    end
  end

  def linked_description(collection)
    content = collection.description
    collection.hashtags.each do |hashtag|
      content.gsub!("##{hashtag.name}",
                    link_to("##{hashtag.name}", hashtag_path(locale: assigned_locale, hashtag: hashtag.name)).to_s)
    end
    simple_format content
  end

  def information_span(item, collection)
    product = collection_products(collection)[item]
    return if product.blank?

    content_tag(:span, class: 'information_span', id: "#{item}infobox") do
      inner = content_tag(:span, class: 'information_left') do
        right = content_tag(:span, product.try(:brand).try(:name))
        right << content_tag(:span, '/')
        right << content_tag(:span, product.categories.last.name)
      end
      inner << content_tag(:span, class: 'information_right') do
        number_to_currency(product.price, unit: product.currencyCode)
      end
      content_tag(:span, class: :inner) do
        inner
      end
    end
  end

  def collection_products(collection)
    return @collection_products if @collection_products.present?

    @collection_products = {}
    collection.products.each do |product|
      @collection_products[product.id] = product
    end
    @collection_products
  end

  def css_calculate_dimension(item, _collection)
    left    = 566.0 * (item.position_x.to_f / @collection.width)
    top     = 442.0 * (item.position_y.to_f / @collection.height)
    width   = 566.0 * (item.width.to_f / @collection.width)
    height  = 442.0 * (item.height.to_f / @collection.height)
    "left:#{left}px;top:#{top}px;height:#{height}px;width:#{width}px;transform: rotate(#{item.rotation}deg)"
  end
end
