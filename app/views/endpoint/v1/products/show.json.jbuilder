# frozen_string_literal: true

json.product do
  json.partial! 'endpoint/v1/products/product', product: @product
end
