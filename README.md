# OpenPPRN

[![Build Status](https://travis-ci.org/myapnea/www_myapnea_org.svg)](https://travis-ci.org/myapnea/www_myapnea_org)
[![Dependency Status](https://gemnasium.com/myapnea/www_myapnea_org.png)](https://gemnasium.com/myapnea/www_myapnea_org)
[![Code Climate](https://codeclimate.com/github/myapnea/www_myapnea_org/badges/gpa.svg)](https://codeclimate.com/github/myapnea/www_myapnea_org)

A collaboration to build an open-source solution for creating patient-powered research networks.


## Installation

```
gem install bundler
```

This readme assumes the following installation directory: /var/www/www_myapnea_org

```
cd /var/www

git clone https://github.com/remomueller/www_myapnea_org.git

cd www_myapnea_org

bundle install
```

Install default configuration files for database connection, email server connection, server url, and application name.

```
ruby lib/initial_setup.rb

bundle exec rake db:migrate RAILS_ENV=production

bundle exec rake db:fixtures:load RAILS_ENV=production

bundle exec rake db:seed RAILS_ENV=production

bundle exec rake assets:precompile RAILS_ENV=production
```

Run Rails Server (or use Apache or nginx)

```
rails s -p80
```

Open a browser and go to: [http://localhost](http://localhost)

All done!
