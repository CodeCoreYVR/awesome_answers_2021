require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module AwesomeAnswersMarch202
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.active_storage.service = :local
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # active job is the background job framework built into rails. It handles running stuff in the background
    # delayed_job is a queue manager. It decides which jobs should run
    config.active_job.queue_adapter = :delayed_job

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        # origins accepts an array of domain names. These are all the whitelisted DOMAINS that are allowed to send CORS (cross origin ajax requests) requests
        origins 'localhost:5500', '127.0.0.1:5500', 'localhost:8080', '127.0.0.1:8080'
        resource(
          "/api/*", # only allow CORS to paths that look like /api
          headers: :any, # allow requests to contain any headers
          credentials: true, # because we're sending cookies we must have CORS allow credentials
          methods: [:get, :post, :delete, :patch, :put, :options] # allow only these methods
        )
      end
    end

  end
end
