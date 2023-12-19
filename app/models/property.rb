# frozen_string_literal: true

class Property < ActiveRecord::Base
  %w[shop collection category].each do |x|
    mount_uploader "#{x}_highlight_image".to_s, PropertyUploader
  end
end
