# CarrierWave.configure do |config|
#  config.fog_credentials = {
#       provider: "AWS",
#       aws_access_key_id: ENV["AKIAJADPJEW26KLP3UQA"],
#       aws_secret_access_key: ENV["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"]
#  }
#  config.fog_directory = ENV["o-meter-images"]
# end 



CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => '',       # required
    :aws_secret_access_key  => '',       # required
    :region                 => 'us-west-2'  # required, defaults to 'us-east-1'
    
  }
  config.fog_directory  = 'o-meter-images'

end