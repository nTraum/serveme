source 'https://rubygems.org'

gem 'rails', '>= 4.1.0.rc1'
gem 'haml'
gem 'protected_attributes'
gem "actionpack-action_caching"
gem 'puma'
gem 'omniauth-openid'
gem 'omniauth-steam'
gem 'devise'
gem 'rubyzip'
gem 'steam-condenser', :github => 'koraktor/steam-condenser-ruby'
gem 'logs_tf'

#Map uploads
gem 'carrierwave'
gem 'rbzip2', :github => 'koraktor/rbzip2'

#Logdaemon
gem 'tf2_line_parser'
gem 'eventmachine'
gem 'dante'

gem 'net-ssh-simple'
gem 'net-ssh'
gem 'net-sftp'
gem 'draper'
gem 'will_paginate'
gem 'zeroclipboard-rails'
gem "google_visualr"
gem 'rack-cache'
gem 'paypal-sdk-rest'
gem 'sidekiq'
gem 'sidetiq', :github => "ggilder/sidetiq", :ref => "204091b"
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'mechanize'
gem 'american_date'

platforms :rbx, :ruby do
  gem 'ffi'
end

platforms :rbx do
  gem 'rubysl'
  gem "racc"
  gem "rubinius-coverage"
  gem "rubysl-test-unit"
end
platforms :ruby do
  gem 'mysql2'
  gem 'therubyracer'
  gem 'oily_png'
  gem 'sys-proctable',    :require => 'sys/proctable'
end
platforms :jruby do
  gem 'therubyrhino'
  gem 'activerecord-jdbcmysql-adapter'
  gem 'chunky_png'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms => :ruby

  #Deployment
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'capistrano', "~> 2.0"
  gem 'capistrano-maintenance'
  gem "capistrano-sidekiq"
  gem 'rvm-capistrano'
  gem 'query_reviewer'
end

group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'pry-nav'
  gem 'zonebie'
end

group :test_tools do
  gem 'coveralls', require: false
  gem 'fuubar'
end

group :cucumber do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'fuubar-cucumber'
end

group :production do
  gem "sentry-raven"
  gem 'dalli'
end

group :test do
  #Load minitest explicitly to work around shoulda issue
  gem "minitest"
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
  gem 'delorean'
end

gem 'uglifier'
gem 'jquery-rails'
gem "compass-rails", "~> 1.1.7"
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'will_paginate-bootstrap'
gem 'execjs'
gem 'font-awesome-rails'
gem 'coffee-rails'
