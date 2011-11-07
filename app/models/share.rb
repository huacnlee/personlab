# coding: utf-8 
require "rubygems"
require 'simple-rss'
require 'open-uri'

class Share
  
  def self.api_url(setting)     
    "http://www.google.com/reader/public/atom/user%2F#{setting.google_reader_id}%2Fstate%2Fcom.google%2Fbroadcast"
  end
  
  def self.find_all(setting,force = false)
    feeds = []
    feed = SimpleRSS::parse open(api_url(setting))
    if feed != nil
      feed.items.each do |item|
				continue if item.blank?
        feeds << {  
          "title" => item.title,
          "link" => item.link,
          "updated_at" => item.updated,
          "author" => item.author,
        }
      end
    end
    feeds
  end
end
