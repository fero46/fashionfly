if @category.main_taxon?
  json.categories @category.categories do |json, category|
    json.id category.id
    json.name category.name
  end
else
  json.categories @category.categories do |json, category|
    json.id category.id
    json.name category.name
  end

  json.brands Brand.all do |json, brand|
    json.id brand.id
    json.name brand.name
  end

  json.colors Colorization.all do |json, color|
    json.id color.id
    json.hex color.name    
  end

  json.price_ranges ['0-50','50-100', '100-250', '250-500', '>500' ] do |json, price|
    json.range price 
  end

end