# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )


  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  config.load_paths += %W( #{RAILS_ROOT}/app/sweepers )

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  config.active_record.observers = :comment_observer, :post_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Beijing'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :zh_cn
  
  # check will_paginate installed.
  config.gem 'will_paginate'	
	config.gem 'macaddr', :version => '~> 1.0'
	config.gem 'RedCloth'
	config.gem 'simple-rss'
	config.gem 'twitter4r', :lib => "twitter"

end

Time::DATE_FORMATS[:short_date_string] = "%y年%m月%d日"
Time::DATE_FORMATS[:short_date] = "%y-%m-%d"
Time::DATE_FORMATS[:short_time_string] = "%y年%m月%d日 %H:%M"
Time::DATE_FORMATS[:short_time] = "%y-%m-%d %H:%M"

# custom configs
APP_VERSION = '0.3'

APP_DOMAIN = 'huacnlee.com'

require 'will_paginate'
# will_paginate custom label
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '« 上一页'
WillPaginate::ViewHelpers.pagination_options[:next_label] = '下一页 »'

# captcha secret key
CAPTCHA_SALT = "8929&**&@#"
