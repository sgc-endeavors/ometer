
CarrierWave.configure do |config|
  config.fog_credentials = {
   :provider =>  "AWS",       # required
   :aws_acces_key_id => "AWS_ACCESS_KEY_ID",
   :aws_secret_access_key => "AWS_SECRET_ACCESS_KEY"  
  }
  config.fog_directory  = "S3_bucket_name"

end
