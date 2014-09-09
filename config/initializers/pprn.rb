#Load the PPRN specific data
PPRNS = YAML.load_file("config/pprn.yml")
Rails.application.config.uservoice_api_key = "H39t0NrsoAK7oVfEnDrkQ"
Rails.application.config.google_analytics_web_property_id = "UA-53742602-1" # eg. "UA-XXXX-1"
