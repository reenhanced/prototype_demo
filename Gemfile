source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'mysql2'
gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'carmen-rails'#, '~> 1.0.0.beta3'
gem 'devise'
gem "haml-rails"
gem 'jquery-rails'

gem 'therubyracer', :require => 'v8'

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
