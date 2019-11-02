source 'https://rubygems.org'
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'rack-cors'
gem 'mini_racer'
gem 'httparty'
gem 'awesome_print'

# Auth
gem 'devise', '~> 4.7'

# Front-end
gem 'bootstrap', '~> 4.0.0'
gem 'bootstrap-datepicker-rails', '~> 1.7'
gem 'font-awesome-rails'
gem 'nested_form_fields', '~> 0.8'
gem 'trix-rails', require: 'trix'
gem 'will_paginate', '~> 3.1.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Image processing
gem 'carrierwave'
gem 'mini_magick'

# Audio processing
gem 'carrierwave-audio'
gem 'ruby-mp3info'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  # AWS adapter for CarrierWave
  gem 'fog-aws', '~> 1.2'
  gem 'redis-rails', '~> 5.0.2'
  gem 'sidekiq', '~> 5.1.3'
  gem 'whenever'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
