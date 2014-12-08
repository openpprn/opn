#####################
# The title of your network and the conditions it helps
#####################
PPRN = "MyApnea"
PPRN_TITLE = "MyApnea.Org"
PPRN_CONDITION = "Sleep Apnea"
PPRN_CONDITIONS = ["Sleep", "Apnea"]
PPRN_SUPPORT_EMAIL = "support@myapnea.org"
PPRN_THEME_NAME = ""

#####################
# External Accounts
#####################
OODT_ENABLED = false
VALIDIC_ENABLED = false


# Load dummy health data for demonstration
DUMMY_HEALTH_DATA = YAML.load_file("config/health_data.yml")
DUMMY_DATA_SOURCES = DUMMY_HEALTH_DATA["data_sources"]
DUMMY_DATA_SOURCE_TYPES = DUMMY_HEALTH_DATA["data_source_types"]

# Uservoice
USERVOICE_ID = "33zOAGHPa60Hy8T2vEaQLg"

# Google Analytics ID
GOOGLE_ANALYTICS_ID = ""

# Facebook
FB_APP_ID = ""
FB_APP_SECRET = ""