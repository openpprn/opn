# OpenPPRN

[![Build Status](https://travis-ci.org/openpprn/opn.svg?branch=master)](https://travis-ci.org/openpprn/opn)
[![Dependency Status](https://gemnasium.com/openpprn/opn.svg)](https://gemnasium.com/openpprn/opn)
[![Code Climate](https://codeclimate.com/github/openpprn/opn/badges/gpa.svg)](https://codeclimate.com/github/openpprn/opn)

A collaboration to build an open-source solution for creating patient-powered research networks.

## Before Starting Installation

Make sure you have reviewed and installed any [prerequisites](https://github.com/openpprn/opn/blob/master/PREREQUISITES.md).

## Installation

```
gem install bundler
```

This README assumes the following installation directory: /var/www/opn

```
cd /var/www

git clone https://github.com/openpprn/opn.git

cd opn

bundle install

figaro install

```

Install default configuration files for database connection, email server connection, server url, and application name.

```
ruby lib/initial_setup.rb


It will generate /config/application.yml and pprn.rb. You can open and modify them accordingly. Add the appropriate keys you've gotten from the third party developers. For any service you aren't using, you can leave the lines out. 

```
Secret Keys
Application.yml will contain your production secret key and key base, make sure the following line is in secrets.yml

production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

AND PUT NO SECRET KEYS IN SECRETS.YML! IT IS CHECKED INTO SOURCE CONTROL.



bundle exec rake db:migrate RAILS_ENV=production

bundle exec rake assets:precompile RAILS_ENV=production

bundle exec rake surveys:create #to get the surveys up and running
```


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


