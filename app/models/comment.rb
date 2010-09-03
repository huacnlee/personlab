# coding: utf-8 
class Comment < ActiveRecord::Base
  belongs_to :post,:counter_cache => "comment_count"

  validates_presence_of :author,:email,:body
  scope :recents, :order => "id desc"
	
  before_create :default_value
  def default_value
    self.status = 1 if self.status.blank?
  end
  
  def created_at_s
    I18n.l created_at
  end
  
  def self.find_list(page = 1, per_page = 20,options = {})
    with_scope :find => options do
      paginate(:page => page, :per_page => per_page, :conditions => ['status = ?', 1])
    end
  end
end

