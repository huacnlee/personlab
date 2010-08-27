# coding: utf-8 
class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

  def posts_count
    posts.count
  end

  # override save for name unique
  def save
    old = self.class::find_by_name(self.name)
    if old
      logger.debug { "existed!" }
      self.id = old.id
      self.created_at = old.created_at
      self.updated_at = old.updated_at
      return true
    else
      super
    end
  end
  
  def self.find_top(size = 10)
    paginate :per_page => size, :page => 1
  end
end
