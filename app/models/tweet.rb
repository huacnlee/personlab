# Twitter API data model
require "twitter"
# virtual model not have database table
class Tweet < ActiveRecord::Base
  
  def self.get_home_messages(uid = 'huacnlee',count = 5,force = false)
    msgs = Rails.cache.read("data/tweet/#{uid}")
    if not msgs or force
      config_file = "#{RAILS_ROOT}/config/twitter.yml"
      twitter = Twitter::Client.from_config(config_file,RAILS_ENV)
      msgs = twitter.timeline_for(:user, :id => uid,:count => count)
      Rails.cache.write("data/tweet/#{uid}",msgs)
    end
    
    msgs
  end
end
