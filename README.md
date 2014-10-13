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
```

Install default configuration files for database connection, email server connection, server url, and application name.

```
ruby lib/initial_setup.rb

ruby config/pprn.rb

bundle exec rake db:migrate RAILS_ENV=production

bundle exec rake assets:precompile RAILS_ENV=production
```

To set up your secret keys, run
figaro install

Add the following lines to the /config/application.yml file it generates, complete with appropriate keys you've gotten from the third party developers. For any service you aren't using, you can leave the lines out:

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

```
Run Rails Server (or use Apache or nginx)

```
rails s
```

Open a browser and go to: [http://localhost:3000](http://localhost:3000)

All done!
