# frozen_string_literal: true

module WidgetsHelper
  def widget_collection_image_tag(collection)
    host = if Rails.env.development? || Rails.env.test?
             'http://localhost:3000'
           else
             ''
           end
    image_tag(host + collection.image.original.url,
              class: 'collection_image',
              alt: collection.title,
              title: collection.title)
  end
end
