json.id collection.id
json.price collection.price
json.name collection.title
json.images do
  if Rails.env.development? || Rails.env.test?
    json.original request.protocol + request.host_with_port + collection.image.original.url
  else
    json.original collection.image.original.url
  end
  if Rails.env.development? || Rails.env.test?
    json.preview request.protocol + request.host_with_port + collection.image.preview.url
  else
    json.preview collection.image.preview.url
  end
  if Rails.env.development? || Rails.env.test?
    json.thumb request.protocol + request.host_with_port + collection.image.thumb.url
  else
    json.thumb collection.image.thumb.url
  end
end
json.visits collection.visits_count
json.likes collection.favorites_count

json.user do
  json.id collection.user.present? ? collection.user.id : '-1'
  if collection.user.present?
    json.name collection.user.name
    json.avatars do
      if Rails.env.development? || Rails.env.test?
        json.detail_view request.protocol + request.host_with_port + collection.user.avatar.detail_view.url
      else
        json.detail_view collection.user.avatar.detail_view.url
      end

      if Rails.env.development? || Rails.env.test?
        json.smaller request.protocol + request.host_with_port + collection.user.avatar.smaller.url
      else
        json.smaller collection.user.avatar.smaller.url
      end

      if Rails.env.development? || Rails.env.test?
        json.mini request.protocol + request.host_with_port + collection.user.avatar.mini.url
      else
        json.mini collection.user.avatar.mini.url
      end
   end
  end
end

if @with_extra_info
  json.description collection.description
  json.partial! 'endpoint/v1/comments/comments', comments: collection.comments
  @with_extra_info = false
  json.products collection.products do |json, similar|
    json.partial! 'endpoint/v1/products/product', product: similar
  end
end