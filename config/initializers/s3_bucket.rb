S3CONNECTION = AWS::S3.new( access_key_id: Mybema::Application.secrets.amazon_access_key_id,
                            secret_access_key: Mybema::Application.secrets.amazon_secret_access_key)
ASSET_BUCKET = S3CONNECTION.buckets[Mybema::Application.secrets.amazon_bucket]