json.pagination do |json|
  json.current_page @collections.current_page
  json.total_pages @collections.total_pages
  json.first_page @collections.first_page?
  json.last_page @collections.last_page?
  json.total_count @collections.total_count
end

json.collections @collections do |json, collection|
  json.partial! 'endpoint/v1/collections/collection', collection: collection
end