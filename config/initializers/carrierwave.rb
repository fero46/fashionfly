require 'carrierwave/storage/fog'

CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      =>  'x',
      :aws_secret_access_key  => 'x',
      :region                 => 'eu-central-1'
    }
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.fog_directory = 'fashionfly'
  end
end
