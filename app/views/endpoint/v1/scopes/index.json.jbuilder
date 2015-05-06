json.scopes @scopes do |json, scope|
  json.id  scope.id
  json.locale scope.locale
  json.language scope.language
  json.region_code scope.region_code
end