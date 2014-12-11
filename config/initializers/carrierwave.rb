CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      =>  'some_access_key_id',
      :aws_secret_access_key  => 'some_secret_key',
      :region                 => 'eu-west-1'
    }
    config.fog_directory = 'bucket_name'
  end
end