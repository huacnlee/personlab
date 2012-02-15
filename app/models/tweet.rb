# coding: utf-8 
# Twitter API data model
require "twitter"
# virtual model not have database table
class Tweet < ActiveRecord::Base
  
  def self.gets(uid = 'huacnlee',count = 5,force = false)
    key = "data/tweet/#{uid}/#{count}"
    msgs = Rails.cache.read(key)
    if not msgs or force      
      begin
        msgs = Twitter.user_timeline(uid, :count => count, :include_rts => true)
        Rails.cache.write(key,msgs, :expires_in => 15.minutes)
      rescue => e
        Rails.logger.error("Tweet.gets failed: #{e}")
        msgs = []
      end
    end
    msgs
  end
end
