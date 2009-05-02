class Comment < ActiveRecord::Base
  belongs_to :post

  def summary
    body.truncate_html(100)
  end
  
  def created_at_s
    created_at.to_s(:short_time_string)
  end
  
  def self.find_list
    find(:all, :conditions => ['status = ?', 1], :order => "created_at asc")
  end
  
  def self.find_recent(size = 10, options = {})
    with_scope :find => options do
      paginate :page => 1, :per_page => size, :conditions => ['status = ?', 1], :order => "created_at desc"
    end
  end
end
