# coding: utf-8 
require "string_extensions"
class Category < ActiveRecord::Base
	validates_presence_of :name
	
	has_many :posts
	
	before_update :recount_posts_count
	
	def recount_posts_count
		self.posts_count = self.posts.count
	end
end
