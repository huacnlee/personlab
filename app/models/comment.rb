class Comment < ActiveRecord::Base
  belongs_to :post

  def created_at_s
    created_at.to_s(:short_time_string)
  end
  
  def self.find_list
    find(:all, :conditions => ['status = ?', 1], :order => "created_at asc")
  end
end
