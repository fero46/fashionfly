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
      prefix = category_breadcrumb_text category.parent
    end
    return (prefix.present? ? prefix + "/" : '' ) + category.name 
  end


end
