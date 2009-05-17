require "rubygems"
require 'simple-rss'
require 'open-uri'
require "lib/string"

class Share < ActiveRecord::Base
  
  def self.api_url(setting)     
    "http://www.google.com/reader/public/atom/user%2F#{setting.google_reader_id}%2Fstate%2Fcom.google%2Fbroadcast"
  end
  
  def self.find_all(setting)
    @expire_minutes = 1.days.minutes
    cache_key = "data/shares"
    feeds = Rails.cache.read(cache_key)
    if not feeds
       feeds = []
        feed = SimpleRSS::parse open(api_url(setting))
        if feed != nil
          feed.items.each do |item|
            feeds << {  
              "title" => item.title,
              "link" => item.link,
              "content" => item.content == nil ? item.summary.html_decode.remove_html_tag()[0..500] + '...' : item.content.html_decode.remove_html_tag()[0..500] + '...',
              "updated_at" => item.updated,
              "author" => item.author,
            }
          end
        end
        Rails.cache.write(cache_key,feeds,:expires_in => @expire_minutes)
    end
    feeds
  end
end
