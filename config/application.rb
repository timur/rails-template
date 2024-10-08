require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsReactImportmap
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, see https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#config-autoload-lib-ignore.
    config.autoload_lib(ignore: %w(assets tasks))
    config.i18n.default_locale = :de

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.middleware.use Rack::Deflater

    config.active_record.sqlite3_production_warning=false

    #config.active_storage.variant_processor = :vips

    config.active_job.queue_adapter = :solid_queue
    config.solid_queue.connects_to = { database: { writing: :queue, reading: :queue } }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
