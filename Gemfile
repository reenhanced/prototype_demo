source 'https://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-2-stable'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets, :staging do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'carmen-rails'
gem 'cancan'
gem 'devise'
gem "draper"
gem "haml-rails"
gem 'jquery-rails'
gem 'audited-activerecord', :git => 'git://github.com/reenhanced/audited.git'

gem 'therubyracer', :require => 'v8'

# Rails 4 preview stuff
gem 'strong_parameters', :git => 'git://github.com/rails/strong_parameters.git'

# Vagrant VM gems
gem 'chef'
gem 'vagrant', '~> 1.0.5'
gem 'librarian'

group :staging do
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development, :test do
  gem 'heroku'
  gem 'capybara-webkit'
  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'timecop'
  gem 'zeus'
end

group :development do
  gem "nifty-generators"
end

group :test do
  gem "email_spec", ">= 1.2.1"
  gem "shoulda-matchers"
end

group :cucumber do
  gem 'headless'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'launchy'
end
