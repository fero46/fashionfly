# frozen_string_literal: true

json.collection do
  json.partial! 'endpoint/v1/collections/collection', collection: @collection
end
