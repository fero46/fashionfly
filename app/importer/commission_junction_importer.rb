class CommissionJunctionImporter < GenericImporter

  PRODUCT = 'product'
  CATEGORY = 'advertisercategory'
  UPC = 'upc'

  def categories
    categories = []
    document.root.children.each do |tag|
      if tag.name == PRODUCT
        cat = filter_category(tag)
        categories << cat if cat.present?
      end
    end
    categories.uniq
  end

  def import
    total_counter = total_count
    actual_counter = 0
    @affiliate.products.update_all(dirty: true)
    document.root.children.each do |tag|
      values = {}
      if tag.name == PRODUCT
        actual_counter+=1
        if actual_counter % 20 == 0
          @affiliate.percent = ((actual_counter.to_f/total_counter.to_f).to_f * 100).to_i
          @affiliate.save
        end
        next if @affiliate.skip_items > actual_counter
        tag.children.each do |t|
          values[t.name] = t.content
        end
      end

      id = values[UPC]
      if find_mapping(product_category(values)).present?
        next if product_remote_image(values).blank?
        product = Product.where(affiliate_id: @affiliate.id, 
                                affi_code: id,
                                scope_id: @scope.id).first_or_create
        product.premium = @affiliate.premium
        product.save
        Categorization.where(product_id: product.id).destroy_all
        update_product_categories(product, values)
        go = product.lastModified==product_last_modified(values)
        puts "soll ich springen ? #{go}" 
        product = update_product_attributes product, values
        next if go
        update_product_images product, values
        product.update(published: true)
      else
        product = Product.where(affiliate_id: @affiliate.id, 
                      affi_code: id,
                      scope_id: @scope.id).first
        if product.present?
          product.dirty = false
          product.published = false
          product.save
        end
      end
      @affiliate.skip_items = actual_counter
      @affiliate.save
    end
    @affiliate.products.where(dirty: true).update_all(published: false)
    @affiliate.products.where(dirty: true).update_all(dirty: false)        
    @affiliate.skip_items = 0
    @affiliate.percent = 100
    @affiliate.save
  end

  def product_remote_image values
    values[@affiliate.image_tag]
  end

  def total_count
    counter = 0
    document.root.children.each do |tag|
      counter+=1 if tag.name == PRODUCT
    end
    counter
  end


  def filter_category node
    node.children.each do |tag|
      return tag.content if tag.name == @affiliate.category_tag
    end
    'IGNORED'
  end


end