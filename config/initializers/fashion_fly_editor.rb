FashionFlyEditor::Engine.configure do |config|
  config.categories_endpoint = "/de/api/categories"
  config.startup_category_id = 487
  config.callbacks << :assign_collection
end