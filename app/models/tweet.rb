# coding: utf-8 
# Twitter API data model
require "twitter"
# virtual model not have database table
class Tweet < ActiveRecord::Base
  
  def self.gets(uid = 'huacnlee',count = 5,force = false)
    msgs = Rails.cache.read("data/tweet/#{uid}")
    if not msgs or force      
      msgs = Twitter.user_timeline(uid, :count => count)
      Rails.cache.write("data/tweet/#{uid}",msgs, :expires_in => 20.minutes)
    end
    
    msgs
  end
end
