json.pagination do |json|
  json.current_page @products.current_page
  json.total_pages @products.total_pages
  json.first_page @products.first_page?
  json.last_page @products.last_page?
  json.total_count @products.total_count  
end

json.products @products do |json, product|
  json.id product.id
  json.price product.price
  json.name product.name
  json.image request.protocol + request.host_with_port + product.image.url
  json.width product.width
  json.height product.height
  json.url product.deepLink
end