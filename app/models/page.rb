# coding: utf-8 
class Page < ActiveRecord::Base
  validates_uniqueness_of :title, :slug, :case_sensitive => false , :message => "已经有同名的存在,请检查是否重发了."
  
  # status
  STATUS = [
    ["请选择状态",-1],
    ["发布",1],
    ["草稿",2],
    ].freeze
    
  scope :publish, where(:status => 1)
  
  # before validation
  before_validation :safe_slug_for_validation
  def safe_slug_for_validation
    self.slug = self.slug.safe_slug
  end
    
  # custom methods
  public
  def self.find_show(slug)
    find_by_slug_and_status(slug,1)
  end
 
end
