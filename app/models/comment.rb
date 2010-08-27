# coding: utf-8 
class Comment < ActiveRecord::Base
  belongs_to :post,:counter_cache => "comment_count"

  validates_presence_of :author,:email,:body
	default_scope :order => 'id ASC'
	
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
  
  def self.find_recent(size = 10, options = {})
    with_scope :find => options do
      paginate :page => 1, :per_page => size, :conditions => ['status = ?', 1], :order => "id desc"
    end
  end
  
end

