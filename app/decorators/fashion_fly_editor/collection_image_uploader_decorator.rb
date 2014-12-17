FashionFlyEditor::CollectionImageUploader.class_eval do

  include CarrierWave::RMagick

  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :fog
  end


  version :original do
    process :resize_to_fit => [566, 442]
  end

  version :preview do
    process :resize_to_fit => [272, 212]
  end

  version :thumb do
    process :resize_to_fit => [100, 78]
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