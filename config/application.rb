require File.expand_path('../boot', __FILE__)

# require 'rails/all'
require 'action_controller/railtie'
# require 'active_record/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Include Sequel Plugins here
    config.sequel.after_connect = proc do
      Sequel::Model.db.extension :pagination
      Sequel::Model.db.extension :pg_hstore

      Sequel::Model.plugin :timestamps, update_on_create: true
      Sequel::Model.plugin :validation_helpers
      Sequel::Model.plugin :association_proxies
      # Sequel::Model.plugin :active_model
      # Sequel::Model.plugin :dirty
      # Sequel::Model.db.extension :pg_array
      # Sequel::Model.db.extension :pg_hstore
    end

    config.generators do |g|
      g.test_framework :minitest
      g.helper false
      g.assets false
      g.routes false
    end

    config.react.addons = true
    config.react.variant = :development
  end
end
