source 'http://rubygems.org'

gem 'rails', '3.2.13'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem "therubyracer" #an alternative to the ruby racer

gem 'jquery-rails'

gem "authlogic"
gem "meta_search"
gem 'tinymce-rails'
gem "awesome_nested_set", ">= 2.1.2"
gem 'will_paginate'
gem "paperclip"
gem 'mercury-rails'
gem 'active_attr'
gem 'prawn'
gem 'nokogiri'
gem 'delayed_job_active_record'

gem "friendly_id"
gem "rails3-jquery-autocomplete"

# Use unicorn as the web server
# gem 'unicorn'

group :production do
  gem "thin"
  gem 'newrelic_rpm'
end

# Deploy with Capistrano
# gem 'capistrano'

group :development do
  gem 'capistrano'
  gem 'rvm-capistrano'

  # To use debugger
  #gem "ruby-debug-base19", "0.11.26"
  #gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
