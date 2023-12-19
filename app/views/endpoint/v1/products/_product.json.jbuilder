# frozen_string_literal: true

json.id product.id
json.price product.price
json.name product.name
json.images do
  if Rails.env.development? || Rails.env.test?
    json.image_big request.protocol + request.host_with_port + product.original.detail_view.url
  else
    json.image_big product.original.detail_view.url
  end
  if Rails.env.development? || Rails.env.test?
    json.image_small request.protocol + request.host_with_port + product.original.smaller.url
  else
    json.image_small product.original.smaller.url
  end
end
json.transparent_images do
  if Rails.env.development? || Rails.env.test?
    json.image request.protocol + request.host_with_port + product.image.url
  else
    json.image product.image.url
  end
  if Rails.env.development? || Rails.env.test?
    json.selectable_image request.protocol + request.host_with_port + product.image.selectable.url
  else
    json.selectable_image product.image.selectable.url
  end
end
json.width product.width
json.height product.height
json.url product.deepLink

json.likes product.favorites_count

if @with_extra_info
  json.description product.description
  json.affiliate_logo product.affiliate.logo.url
  json.free_shipping product.affiliate.free_shipping
  json.pay_invoice product.affiliate.pay_invoice
  json.premium product.affiliate.premium
  @with_extra_info = false
  json.similar_products product.similar_products do |json, similar|
    json.partial! 'endpoint/v1/products/product', product: similar
  end
  json.used_in_collections product.used_in_collections do |json, _collections|
    json.partial 'endpoint/v1/collections/collection'
  end
end
