if ENV['HEROKU']
  require 'actionpack_overrides'
  Rails.application.config.middleware.insert_before(ActionDispatch::BestStandardsSupport,HerokuAssetCacher)
end
