# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.2.0"

# back-end
gem "acts_as_list" # ActsAsList is a small extension to the ActiveRecord::Base class to allow easy creation of sortable lists
gem "cancancan" # The authorization Gem for Ruby on Rails
gem "devise" # Flexible authentication solution for Rails with Warden
gem "devise-i18n"
gem "mysql2"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection" # This is used to solve "Authenticity error", as described in https://stackoverflow.com/questions/66086606/could-not-authenticate-you-from-googleoauth2-because-authenticity-error
gem "pagy", "~> 6.1" # Pagination support
gem "propshaft"
gem "rails-i18n" # Add support for internationalization (i18n) to Rails
gem "trilogy" # Use trilogy as the database for Active Record
gem "solid_cable", "~> 3.0"

# front-end
gem "importmap-rails" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "phosphor_icons", "~> 0.2.0"
gem "prawn" # Fast, Nimble PDF Generation For Ruby
gem "prawn-grouping" # Keep elements together on a page
gem "prawn-markup" # Render HTML and Markdown in Prawn PDFs
gem "simple_form" # Use SimpleForm for forms
gem "slim-rails"
gem "stimulus-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "tailwindcss-rails"
gem "turbo-rails" # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "hotwire_combobox"

gem "lookbook"
gem "view_component"

# security
# gem "bcrypt", "~> 3.1.7" # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]

# devops
gem "kamal"
gem "puma", ">= 5.0" # Use the Puma web server [https://github.com/puma/puma]
gem "rorvswild"
gem "solid_errors", "~> 0.6.1"


# other
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb
gem "tzinfo-data", platforms: %i[mswin mswin64 mingw x64_mingw jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "rack-mini-profiler"

  gem "error_highlight", ">= 0.4.0", platforms: [ :ruby ]
  gem "prosopite" # N+1 query detection
  gem "methodz"
  gem "rubocop"
  gem "rubocop-capybara"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rails-omakase"
  gem "slim_lint"
  gem "tailwind-sorter", "~> 0.3.0", require: false # tailwind class sorter by Matouš Borák
  gem "overcommit"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "sqlite3"

  # github action checks
  gem "brakeman"
  gem "bundler-audit"
  gem "rails_best_practices"
end

gem 'feedback', path: 'feedback'
