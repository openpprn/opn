CarrierWave.configure do |config|
  if Rails.env.test?
    config.root = lambda { File.join( Rails.root, 'test', 'support' ) }
    config.storage = :file
    config.enable_processing = false
  end
end
