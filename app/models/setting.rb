# coding: utf-8 
class Setting < ActiveRecord::Base
  
  def self.find_create
    @setting = first
    if not @setting
      @setting = new(:site_name => "PersonLab Demo", :sub_title => "This is an person website build by Ruby on Rails.", 
        :meta_keywords => "personlab,ruby on rails", 
        :email => "huacnlee@gmail.com",
        :meta_description => "This is an person website build by Ruby on Rails.",
        :fanfou_id => "huacn",
        :google_reader_id => "08982619185204047523",
        :home_show => '')
      @setting.save
    end
    return @setting
  end
end
