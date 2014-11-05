#####################
# The title of your network and the conditions it helps
#####################
PPRN = "myapnea"
PPRN_TITLE = "MyApnea.Org"
PPRN_CONDITION = "Sleep Apnea"
PPRN_CONDITIONS = ["Sleep Apnea", "Apnea"]
PPRN_SUPPORT_EMAIL = "support@myapnea.org"


#####################
# External Accounts
#####################
OODT_ENABLED = true
VALIDIC_ENABLED = false


# Load dummy health data for demonstration
DUMMY_HEALTH_DATA = YAML.load_file("config/health_data.yml")
DUMMY_DATA_SOURCES = DUMMY_HEALTH_DATA["data_sources"]
DUMMY_DATA_SOURCE_TYPES = DUMMY_HEALTH_DATA["data_source_types"]



