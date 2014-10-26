json.categories @categories do |json, category|
  json.id category.id
  json.name category.name
end