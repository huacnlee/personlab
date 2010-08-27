ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :enable_starttls_auto => true,
  :port => 587,
  :domain => "huacnlee.com",
  :authentication => :plain,
  :user_name => "support@huacnlee.com",
  :password => "SU_123123"
}
# action mailer config
ActionMailer::Base.default_content_type = "text/html"
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.default_url_options[:host] = APP_DOMAIN
ActionMailer::Base.raise_delivery_errors = true

# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
