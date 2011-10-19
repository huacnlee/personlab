ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :enable_starttls_auto => true,
  :port => 587,
  :domain => "heroku.com",
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD']
}
# action mailer config
ActionMailer::Base.default_content_type = "text/html"
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.default_url_options[:host] = APP_DOMAIN
ActionMailer::Base.raise_delivery_errors = true

# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
