#####################
# The title of your network and the conditions it helps
#####################
PPRN = "ccfa"
PPRN_TITLE = "CCFA Partners"
PPRN_CONDITION = "Crohn's & Ulcerative Colitis"
PPRN_CONDITIONS = ["Crohn's", "Ulcerative Colitis", "Indeterminate Colitis"]
PPRN_SUPPORT_EMAIL = "support@partners.ccfa.org"


#####################
# External Accounts
#####################
OODT_ENABLED = true
VALIDIC_ENABLED = true


# Load dummy health data for demonstration
DUMMY_HEALTH_DATA = YAML.load_file("config/health_data.yml")
DUMMY_DATA_SOURCES = DUMMY_HEALTH_DATA["data_sources"]
DUMMY_DATA_SOURCE_TYPES = DUMMY_HEALTH_DATA["data_source_types"]



