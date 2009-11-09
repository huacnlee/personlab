class AddPostsCountToCategories < ActiveRecord::Migration
  def self.up
	change_table :categories do |t|
      t.integer :posts_count
    end		
  end

  def self.down
   	change_table :categories do |t|
      t.remove :posts_count
    end
  end
end
