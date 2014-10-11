S3CONNECTION = AWS::S3.new( access_key_id: Mybema::Application.secrets.amazon_access_key_id,
                            secret_access_key: Mybema::Application.secrets.amazon_secret_access_key)
ASSET_BUCKET = S3CONNECTION.buckets[Mybema::Application.secrets.amazon_bucket]

CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => Mybema::Application.secrets.amazon_access_key_id,
      :aws_secret_access_key => Mybema::Application.secrets.amazon_secret_access_key,
      :region                => 'us-east-1'
  }

  config.fog_directory  = ASSET_BUCKET.name
  config.fog_public     = true
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
end