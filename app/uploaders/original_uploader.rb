# frozen_string_literal: true

class OriginalUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :fog
  end

  version :detail_view do
    process resize_to_limit: [550, 650]
  end

  version :smaller do
    process resize_to_limit: [192, 227]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def filename
    @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
