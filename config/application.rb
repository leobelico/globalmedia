require_relative 'boot'
require 'logger'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Globalmedia
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.time_zone = 'Mexico City'
	config.active_record.default_timezone = :local
	config.i18n.default_locale = :es
    config.middleware.use Rack::Attack
    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.active_record.time_zone_aware_attributes = false
    config.middleware.insert_before 0, Rack::Cors do
        allow do
            origins '*'
            resource '*', :headers => :any, :methods => [:get, :post, :options]
        end
    end

    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Origin' => 'http://38.96.148.213:1935/vivecanaltest/myStream.sdp/playlist.m3u8',
        'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")
      }
  end
end
