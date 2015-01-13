class PropertiesController < ScopeController
    load_and_authorize_resource param_method: :property_attributes

  def edit
    @property = @scope.property
  end

  def update
    @scope.property.update(property_attributes)
    redirect_to edit_property_path()
  end


protected

  def property_attributes
    params.require(:property).permit( :shop_highlight_title,
                                      :shop_highlight_image,
                                      :shop_highlight_image_cache,
                                      :shop_highlight_link,
                                      :collection_highlight_title,
                                      :collection_highlight_image,
                                      :collection_highlight_image_cache,
                                      :collection_highlight_link,
                                      :category_highlight_title,
                                      :category_highlight_image,
                                      :category_highlight_image_cache,
                                      :category_highlight_link,
                                      :show_new_startpage)
  end

end
