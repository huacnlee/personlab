# coding: utf-8 
# Fanfou API data model
# virtual model not have database table
class Fanfou < ActiveRecord::Base
  
  def self.get_home_messages(id,len = 4)
    @expire_minutes = 15.minutes
    @fanfou_msgs = Rails.cache.read("data/fanfou/me")
    if not @fanfou_msgs
      @fanfou_msgs = FanfouMoulde.get_messages_by_id(id,len)
      Rails.cache.write("data/fanfou/me",@fanfou_msgs,:expires_in => @expire_minutes)
    end
    
    @fanfou_msgs
  end
end
