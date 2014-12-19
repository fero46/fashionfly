module WidgetsHelper

  def widget_collection_image_tag collection
    if Rails.env.development? || Rails.env.test?
      host = "http://localhost:3000"
    else
      host = ""
    end
    image_tag(host + collection.image.preview.url, 
              class: 'collection_image',
              alt: collection.title,
              title: collection.title)

  end
end
