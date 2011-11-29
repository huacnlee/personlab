# coding: utf-8 
class Setting < ActiveRecord::Base
  
  def self.find_create
    @setting = Rails.cache.read("models/setting1").dup
    if @setting.blank?
      @setting = first
      if not @setting
        @setting = new(:site_name => "PersonLab Demo", :sub_title => "This is an person website build by Ruby on Rails.", 
          :meta_keywords => "personlab,ruby on rails", 
          :email => "huacnlee@gmail.com",
          :meta_description => "This is an person website build by Ruby on Rails.",
          :twitter_id => "huacnlee",
	  :disqus_shortname => "foobar",
          :google_reader_id => "08982619185204047523",
          :home_show => '')
        @setting.save
      end
      Rails.cache.write("models/setting1",@setting)
    end
    return @setting
  end
end
