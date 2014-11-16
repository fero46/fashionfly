json.options @options do |json, option|
  json.type option[:type]
  json.name option[:name]
  json.value option[:value]
  json.label option[:label]
end

json.scope do
  json.id  @scope.id
  json.type @scope.class.name
end

json.collection do
  json.redirect_url  collections_url(@scope.locale) + "/:id"
end

json.categories @categories do |json, category|
  json.id category.id
  json.name category.name
end