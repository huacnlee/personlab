class Category < ActiveRecord::Base
	validates_presence_of :name
	
	has_many :posts
	
	before_update :before_update
	
	def before_update
		self.posts_count = self.posts.count
	end
end