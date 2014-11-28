# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  
  storage :file

  version :detail_view  do
    process resize_to_fit: [250, 250]
  end

  version :smaller do
    process resize_to_fit: [125, 125]
  end

  version :mini do
    process resize_to_fit: [65, 65]
  end

  def default_url
    "/fallback/avatar/" + [version_name, "default.png"].compact.join('_')
  end


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
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
