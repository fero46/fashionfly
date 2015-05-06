json.categories @categories do |json, category|
  json.id category.id
  json.name category.name
  json.parent category.category_id
  json.main_taxon category.main_taxon
end