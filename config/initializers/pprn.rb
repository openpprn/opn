#Load the PPRN specific data
DUMMY_HEALTH_DATA = YAML.load_file("config/health_data.yml")
DUMMY_DATA_SOURCES = DUMMY_HEALTH_DATA["data_sources"]
DUMMY_DATA_SOURCE_TYPES = DUMMY_HEALTH_DATA["data_source_types"]

#####################
# External Accounts
#####################
OODT_ENABLED = true
VALIDIC_ENABLED = true

#####################
# The title of your network and the conditions it helps
#####################
PPRN = "ccfa"
PPRN_TITLE = "CCFA Partners"
PPRN_CONDITION = "Crohn's & Ulcerative Colitis"
CONDITIONS = ["Crohn's", "Ulcerative Colitis", "Indeterminate Colitis"]
SUPPORT_EMAIL = "support@partners.ccfa.org"