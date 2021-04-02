# OpenPPRN

[![Build Status](https://travis-ci.org/openpprn/opn.svg?branch=master)](https://travis-ci.org/openpprn/opn)
[![Dependency Status](https://gemnasium.com/openpprn/opn.svg)](https://gemnasium.com/openpprn/opn)
[![Code Climate](https://codeclimate.com/github/openpprn/opn/badges/gpa.svg)](https://codeclimate.com/github/openpprn/opn)

OpenPPRN is a collaboration between multiple Patient-Powered Research Networks to build an open, shared patient-facing web & mobile technology infrastructure.

With this "Open" PPRN, in the push of a button, you'll be able to deploy a Patient-Powered Research Network that is complete with:

- Patient Registry
- Research Survey Platform
- Health Data Aggregation & Visualization
- Mobile Health Tracking
- Patient Social Network

## Philosophy

### Truly Patient-Centered

Patient-centered and patient-facing. As the interface for your patients to interact with your research network, the web & mobile UI is designed with reward systems from behavior research to engage patients to help advance research for their condition. Patient engagement is the first and primary concern.

### Open

Open Source. Open Data. The data is owned by the patients, stewarded by the patient advocacy group. Freedom: host your network anywhere, move your network and the data at any time. Add to the network to address new needs in the future. That's what makes this an "open PPRN".

### Mobile-First

The whole user experience is designed mobile-first. Patient registration, research surveys, and health tracking are designed to be done from the patient's mobile phone.

### Data-Friendly

Plug-ins to third-party data APIs enable patient health data to be aggregated from hundreds of mobile health apps, so patients can use the tools they find most valuable to track their health data. Plug-ins to patient medical record APIs enable the integration of EHR data. Patients see these visualized on the web & mobile interface.

## Want to Know More?

For full project details visit [OpenPPRN.org](http://openpprn.org)


## Installation

First, make sure you have reviewed and installed any [prerequisites](https://github.com/openpprn/opn/blob/master/PREREQUISITES.md).

Next, install gems:

```
gem install bundler
```

This README assumes the following installation directory: /var/www/opn

```
cd /var/www

git clone https://github.com/openpprn/opn.git

cd opn

bundle install
```

Install default configuration files for database connection, email server connection, server url, and application name.

```
ruby lib/initial_setup.rb

bundle exec rake db:migrate RAILS_ENV=production

bundle exec rake assets:precompile RAILS_ENV=production
```

To set up your secret keys, run

```
figaro install
```

Add the following lines to the /config/application.yml file it generates and modify them accordingly. Add the appropriate keys you've gotten from the third party developers. For any service you aren't using, you can leave the lines out:

```
pprn: "ccfa"
pprn_title: "CCFA Partners"
pprn_condition: "Crohn's & Ulcerative Colitis"
pprn_conditions: "Crohn's, Ulcerative Colitis"
pprn_support_email: "support@ccfapartners.org"

oodt_enabled: "true"
validic_enabled: "true"

uservoice_api_key: 
google_analytics_web_property_id:

validic_access_token: 
validic_organization_id: 

oodt_username: 
oodt_password: 
```

Open PPRN.rb to 
- Configure the basic information about your PPRN
- Enable or Disable Validic and OODT

Run Rails Server (or use Apache or nginx)

```
rails s
```

Open a browser and go to: [http://localhost:3000](http://localhost:3000)

All done!

## Deploying to Heroku

If you are deploying to heroku, to get your application.yml loaded into heroku environment configuration (required to function), do
```
figaro heroku:set -e production
```

## Seeding your Database

If you are just doing test installs or demonstrations of the website, you may want to start with some seed data. Some combination and/or all of these below should get you started:

```
rake db:seed
rake surveys
rake legacy_seed
```



## Modification of Content & Layout

The main navigation of the application is structured like so (in controller#action/view_name format):
- Home#Index
- Research#Index
- HealthData#Index
- Members#Index

If you want to edit any of the major views, you'll find them in the app/views/home, app/views/research, app/views/health_data, & app/views/members directories in .html.haml formats (eg. app/views/home/index.html.haml is the logged-in home page)

Each of those directories contains related partials that are used to help support the views, named with a leading underscore, eg. _tutorial.html.haml, which is the tutorial accessible by tab on most of the major views.

The logged out homepage is Static#Splash (can be found in app/views/static/splash.html.haml). Other static (about/tos/pp) and content pages (lots of text about the network) can be found in this same directory.


