json.scope do
  json.id  @scope.id
  json.type @scope.class.name
end

json.categories @categories do |json, category|
  json.id category.id
  json.name category.name
end