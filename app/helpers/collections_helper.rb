module CollectionsHelper

  def breadcrumb_collection_text collection
    category = collection.category
    collection_category_breadcrumb_text category
  end

  def collection_category_breadcrumb_text category
    return '' if category.blank?
    if category.parent_type == 'Scope'
      prefix = nil
    else
      prefix = collection_category_breadcrumb_text category.parent
    end
    return (prefix.present? ? prefix + "/" : '' ) + category.name 
  end

  def render_embed_code collection
    content =  javascript_include_tag javascript_url("widget"), type:'text/javascript'
    content << content_tag(:div, 'data' => collection.id, 'host' => request.host_with_port) do
      link_to @collection.title, collection_url(assigned_locale, @collection), title: @collection.title, alt: @collection.title
    end
  end


end
