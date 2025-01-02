require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  config.action_cable.url = "wss://navarit.cz/cable"
  config.action_cable.allowed_request_origins = [ "http://navarit.cz/", "http://navarit.cz/" ]

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # this is turned off as we use a reverse proxy to handle SSL
  config.force_ssl = false

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)

  # Change to "debug" to log everything (including potentially personally-identifiable information!)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Replace the default in-process memory cache store with a durable alternative.
  # config.cache_store = :mem_cache_store

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:         "smtp.gmail.com",
    port:            587,
    domain:          "navarit.cz",
    user_name:       Rails.application.credentials.dig(:google, :smtp, :username),
    password:        Rails.application.credentials.dig(:google, :smtp, :password),
    authentication:  "plain",
    enable_starttls: true,
    open_timeout:    5,
    read_timeout:    5
  }
  # Replace the default in-process and non-durable queuing backend for Active Job.
  # config.active_job.queue_adapter = :resque

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production.
  config.active_record.attributes_for_inspect = [ :id ]

  # Enable DNS rebinding protection and other `Host` header attacks.
  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  #
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }

  config.action_mailer.default_url_options = { host: "navarit.cz" }

  # Configure Solid Errors
  config.solid_errors.connects_to = { database: { writing: :errors } }
  config.solid_errors.send_emails = true
  config.solid_errors.email_from = Rails.application.credentials.dig(:solid_errors, :email_from)
  config.solid_errors.email_to = Rails.application.credentials.dig(:solid_errors, :email_to)
  # config.solid_errors.username = Rails.application.credentials.dig(:solid_errors, :username)
  # config.solid_errors.password = Rails.application.credentials.dig(:solid_errors, :password)
end

# config/environments/production.rb
Rails.application.routes.default_url_options[:host] = "navarit.cz"
