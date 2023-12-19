# frozen_string_literal: true

FashionFlyEditor::Engine.configure do |config|
  config.categories_endpoint = 'api/categories'
  config.products_endpoint = 'api/products'
  config.callbacks << :assign_collection
  config.current_user = :current_user
end
