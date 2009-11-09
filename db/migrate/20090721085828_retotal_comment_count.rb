class RetotalCommentCount < ActiveRecord::Migration
  def self.up
    Post.all.each do |p|
      p.comment_count = p.comments.count
      p.save
    end
  end

  def self.down
  end
end
