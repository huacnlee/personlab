# coding: utf-8 
# Twitter API data model
require "twitter"
# virtual model not have database table
class Tweet < ActiveRecord::Base
  
  def self.gets(uid = 'huacnlee',count = 5,force = false)
    key = "data/tweet/#{uid}/#{count}"
    msgs = Rails.cache.read(key)
    if not msgs or force      
      msgs = Twitter.user_timeline(uid, :count => count)
      Rails.cache.write(key,msgs, :expires_in => 15.minutes)
    end
    
    msgs
  end
end
