# frozen_string_literal: true

json.pagination do |json|
  json.current_page @products.current_page
  json.total_pages @products.total_pages
  json.first_page @products.first_page?
  json.last_page @products.last_page?
  json.total_count @products.total_count
end

json.products @products do |json, product|
  json.partial! 'endpoint/v1/products/product', product: product
end
