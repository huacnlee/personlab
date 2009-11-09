class Page < ActiveRecord::Base
  validates_uniqueness_of :title, :slug, :case_sensitive => false , :message => "已经有同名的存在,请检查是否重发了."
  before_save :before_save
  before_validation :before_validation
  
  # status
  STATUS = [
    ["请选择状态",-1],
    ["发布",1],
    ["草稿",2],
    ].freeze
  
  private
  # callback events
  def before_save
  end

  # before validation
  def before_validation
    self.slug = self.slug.safe_slug
  end
    
  # custom methods
  public
  # find list
  def self.find_list(page = 1, per_page = 20,options = {})
    with_scope :find => options do
      paginate :page => page,:per_page => per_page, :order => 'created_at desc'
    end
  end

  def self.find_show(slug)
    find_by_slug_and_status(slug,1)
  end
 
end
