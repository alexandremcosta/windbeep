require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Windbeep
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_job.queue_adapter = :sidekiq

    Envyml.load

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      domain:               'mailgun.org',
      address:              'smtp.mailgun.org',
      user_name:            ENV['MAILER_USERNAME'],
      password:             ENV['MAILER_PASSWORD'],
      authentication:       'plain',
      port:                 587,
      enable_starttls_auto: true
    }
  end
end
