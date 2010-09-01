# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Personlab::Application.load_tasks

# Twitter 
namespace :tweet do
  desc "Twitter reload."
  task :update => :environment do
    setting = Setting.find_create
    if !setting.fanfou_id.blank?
      puts "#{Time.now}"
      puts 'Load tweets from twitter.com...'
      items = Tweet.get_home_messages(setting.fanfou_id,5,true)
      if items.blank?
        puts "Not found or get error."
      else
        puts "Done. there have #{items.count} tweet."
      end
    end
  end
end

# Google Reader 
namespace :reader_share do
  desc "Google Reader reload shere items."
  task :update => :environment do
    setting = Setting.find_create
    puts "#{Time.now}"
    puts 'Load Google Reader share articles...'
    items = Share.find_all(setting,true)
    puts "Done. there got #{items.count} articles from Google Reader."
  end
end

