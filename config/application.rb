require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeightApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    if Rails.env.deveropment?
    #config.web_console.whitelisted_ips = '0.0.0.0/0'
    end
    #config.web_console.whitelisted_ips = '111.239.178.2'
    
    # タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'
    
    # デフォルトのロケールを日本（ja）に設定
    config.i18n.default_locale = :ja
  end
end
