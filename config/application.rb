# coding: utf-8  
require File.expand_path('../boot', __FILE__)

require 'rails/all'

APP_VERSION = "0.7"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Personlab
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/app/sweepers)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :zh_cn

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password,:password_confirm]
  end
end




# *****************************************************************
# *********************    CUSTOM CONFIGS    **********************
# *****************************************************************
# you app domain
APP_DOMAIN = 'huacnlee.com'

# captcha secret key
CAPTCHA_SALT = "8929&**&@#"

# custom feed url, set false to use system feed url
# FEED_URL = "http://feeds.feedburner.com/huacnlee"
FEED_URL = false

# twitter toggle, because there was GFW in China, If you was blocked, set this to false
TWITTER_ENABLE = false

# Google Analytics Account ID
GOOGLE_ANALYTICS_ID = "UA-9745660-1"
# GOOGLE_ANALYTICS_ID = false

# Custom html code in footer.
<<<<<<< HEAD
FOOTER_HTML = "My websites: <a href=\"http://lanxs.com/users/1\" target=\"_blank\" title=\"楠香山\">楠香山</a> <a href=\"http://www.xiangguo.org/chengdu/sells/p9\" target=\"_blank\" title=\"橡果房产网\">橡果房产网</a>"
=======
FOOTER_HTML = ""

# Blog theme
THEME_NAME = 'friendfeed-bret'
>>>>>>> 35706bc52ba4a63438bc0df96077991a9f0f0cbc
