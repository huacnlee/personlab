# coding: utf-8 
require "string_extensions"#
puts "Creating administrator, username:admin password:123123"
User.find_or_create_by_uname(:uname => "admin", :pwd => User.encode("123123"), :name => "Admin")

puts "Creating default menus"
Menu.find_or_create_by_name(:name => "Blog", :url => "/blog",:sort => 10)
Menu.find_or_create_by_name(:name => "About", :url => "/about",:sort => -99)
Menu.find_or_create_by_name(:name => "Work", :url => "/work",:sort => 9)
Menu.find_or_create_by_name(:name => "Share", :url => "/share",:sort => 8)

puts "Creating default pages"
Page.find_or_create_by_slug(:title => "Work", :slug => "work", :body => "This is my work page.", :status => 1)
Page.find_or_create_by_slug(:title => "About", :slug => "about", :body => "About me.", :status => 1)

puts "Creating default categories"
Category.find_or_create_by_slug(:name => "Default", :slug => "default")

puts "Creating sample post"
Post.find_or_create_by_slug(:title => "Hello world.", 
  :slug => "hello-world", 
  :body => "My first weblog in Personlab.", 
  :status => 1, 
  :category_id => Category.first)
