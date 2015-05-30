json.comments @collection.comments do |json, comment|
  json.partial! 'endpoint/v1/comments/comment', comment: comment
end