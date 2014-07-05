Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=2592000"
  config.assets.digest = true
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  config.cache_store = :dalli_store, { expires_in: 12.hours }
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  client = Dalli::Client.new((ENV["MEMCACHIER_SERVERS"] || "").split(","),
                             :username => ENV["MEMCACHIER_USERNAME"],
                             :password => ENV["MEMCACHIER_PASSWORD"],
                             :failover => true,
                             :socket_timeout => 1.5,
                             :socket_failure_delay => 0.2,
                             :value_max_bytes => 10485760)
    config.action_dispatch.rack_cache = {
      :metastore    => client,
      :entitystore  => client
    }
    config.static_cache_control = "public, max-age=2592000"


  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
