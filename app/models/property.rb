class Property < ActiveRecord::Base

  ['shop', 'collection', 'category'].each do |x|
    mount_uploader "#{x}_highlight_image".to_s, PropertyUploader
  end
end
