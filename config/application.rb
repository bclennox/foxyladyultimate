require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module FoxyLadyUltimate
  class Application < Rails::Application
    config.load_defaults 7.0
    config.active_support.cache_format_version = 7.0
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :good_job
    config.active_support.cache_format_version = 7.1
  end
end
