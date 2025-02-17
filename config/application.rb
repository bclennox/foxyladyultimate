require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module FoxyLadyUltimate
  class Application < Rails::Application
    config.load_defaults 7.2
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :good_job
  end
end
