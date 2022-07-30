source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem "active_model_serializers", "~> 0.10.13"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'net-smtp'
gem 'rubocop', require: false

group :test do
  gem "shoulda-matchers", "~> 5.1"
  gem "simplecov", "~> 0.21.2", require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem "spring-commands-rspec", "~> 1.0"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "faker", "~> 2.22"
  gem "rspec-rails", "~> 5.1"
  gem "factory_bot_rails", "~> 6.2"
end
