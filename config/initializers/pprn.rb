#Load the PPRN specific data
PPRNS = YAML.load_file("config/pprn.yml")
Rails.application.config.uservoice_api_key = nil
Rails.application.config.google_analytics_web_property_id = nil # eg. "UA-XXXX-1"
