source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# Ruby 2.3.0

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.7'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

gem 'pg', '~> 0.21.0'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'haml-rails', '~> 1.0'
gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'omniauth-facebook'
gem 'figaro', '~> 1.1', '>= 1.1.1' # variables
# Flexbox rb
gem 'flexbox_rb' # manejara el grid

gem 'annotate'
# Best in place for better edit forms 
gem 'best_in_place', '~> 3.0.1'
# Paperclip para subir archivos
gem "paperclip", "~> 6.0.0"
# Remotipart to upload files via Ajax
gem 'remotipart', github: 'urielhdz/remotipart'
# AASM para states machine
gem 'aasm'
#Activemodel serializers xml to work with draper
gem 'activemodel-serializers-xml', github: 'rails/activemodel-serializers-xml'
# Draper para los decorators
gem 'draper', github: 'audionerd/draper', branch: 'rails5'
# Will paginate para paginación
gem 'will_paginate'
# Sidekiq para los trabajos/job en el background
gem 'sidekiq'
# servidor con el que corre sidekiq web
gem 'sinatra', github: 'sinatra/sinatra', require: nil
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
end

group :development, :test do
  #Metodos de ayuda específicos para las validaciones de Rails
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2' 
  gem 'rspec-rails', '~> 3.8' # Framework pruebas
  # Nos permite crear objetos de la BD para pruebas
  gem 'factory_girl_rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'awesome_print', '~> 1.8'
  gem 'pry'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
