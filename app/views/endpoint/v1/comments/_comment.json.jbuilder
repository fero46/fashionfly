json.comment do |json|
  json.user do
    json.id comment.user.present? ? comment.user.id : '-1'
    if comment.user.present?
      json.name comment.user.name
      json.avatars do
        if Rails.env.development? || Rails.env.test?
          json.detail_view request.protocol + request.host_with_port + comment.user.avatar.detail_view.url
        else
          json.detail_view comment.user.avatar.detail_view.url
        end

        if Rails.env.development? || Rails.env.test?
          json.smaller request.protocol + request.host_with_port + comment.user.avatar.smaller.url
        else
          json.smaller comment.user.avatar.smaller.url
        end

        if Rails.env.development? || Rails.env.test?
          json.mini request.protocol + request.host_with_port + comment.user.avatar.mini.url
        else
          json.mini comment.user.avatar.mini.url
        end
     end
    end
  end
  json.body comment.comment
  json.date comment.created_at
end
