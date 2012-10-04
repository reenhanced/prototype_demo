source 'https://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-2-stable'

gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'carmen-rails'
gem 'devise'
gem "haml-rails"
gem 'jquery-rails'

gem 'therubyracer', :require => 'v8'

# Rails 4 preview stuff
gem 'strong_parameters', :git => 'git://github.com/rails/strong_parameters.git'

# Vagrant VM gems
gem 'chef'
gem 'vagrant', '~> 1.0.5'
gem 'librarian'

group :development, :test do
  gem 'capybara-webkit'
  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'timecop'
end

group :development do
  gem "nifty-generators"
end

group :test do
  gem "email_spec", ">= 1.2.1"
  gem "shoulda-matchers"
  gem 'spork'
end

group :cucumber do
  gem 'headless'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'launchy'
end
