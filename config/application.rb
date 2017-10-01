require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'mime/types'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fashionfly
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.middleware.use Rack::Deflater
    config.eager_load = true
    config.autoload_paths << Rails.root.join('lib')
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.precompile += ['backend.css','backend.js', 'widget.js', 'widget.css', 'overwrites.css', 'style.css', 'language.js', 'mobile.css', 'mobile.js']
    config.assets.precompile += %w( lit/famfamfam_flags/de.png )
    config.assets.precompile += %w( lit/famfamfam_flags/en.png )
    config.assets.precompile += %w( lit/famfamfam_flags/tr.png )
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:de, :en, :tr]
    config.active_job.queue_adapter = :sidekiq
    config.assets.initialize_on_precompile = false
    config.middleware.use Rack::Attack
    config.middleware.use ExceptionNotification::Rack,
      :email => {
          :email_prefix => "[Fehlermeldung] ",
          :sender_address => %{"FashionFly Team" <service@fashionfly.de>},
          :exception_recipients => %w{ferhat@hansehype.de}
        }

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/endpoint/*', :headers => :any, :methods => [:get, :post, :options, :update]
      end
    end

  end
end
