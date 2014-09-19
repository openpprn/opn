CarrierWave.configure do |config|
  config.root = lambda { File.join( Rails.root, 'test', 'support' ) } if Rails.env.test?
end
