# coding: utf-8 
class Setting < ActiveRecord::Base
  
  def self.find_create
    Rails.cache.fetch("models/setting2") do
      setting = first
      if setting.blank?
        setting = create(:site_name => "PersonLab Demo", :sub_title => "This is an person website build by Ruby on Rails.", 
          :meta_keywords => "personlab,ruby on rails", 
          :email => "huacnlee@gmail.com",
          :meta_description => "This is an person website build by Ruby on Rails.",
          :twitter_id => "huacnlee",
    :disqus_shortname => "foobar",
          :google_reader_id => "08982619185204047523",
          :google_analytics_id => '',
          :footer_html => '',
          :home_show => '')
      end
      setting
    end
  end
end
