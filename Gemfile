# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0.7'

gem 'dotenv-rails', groups: %i[development test]

gem 'pg', '~> 1.1'

gem 'puma', '~> 5.0'

gem 'jbuilder'

gem 'pundit', '~> 2.3'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false

gem 'rubocop', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry', '~> 0.14.2'
  gem 'rspec-rails'
end

gem 'bugsnag', '~> 6.26'
