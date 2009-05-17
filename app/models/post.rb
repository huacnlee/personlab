require "lib/string"

class Post < ActiveRecord::Base
  validates_uniqueness_of :title, :slug, :case_sensitive => false , :message => "已经有同名的存在,请检查是否重发了."
  validates_presence_of :title,:body,:status
  has_many :comments
  has_many :tags
  
  # callback events
  before_validation :before_validation
  before_save :before_save
  
  # enum sets
  
  # status
  STATUS = [
    ["请选择状态",-1],
    ["发布",1],
    ["草稿",2],
    ].freeze
  
  # custome field
  
  # string formated created_at
  def created_at_s
    created_at.to_s(:short_date_string)
  end
  
  def summary
    @sumarry_mark = "<!--{/summary}-->"
    if body.index(@sumarry_mark)
      body.split(@sumarry_mark)[0]
    else
      body.truncate_html(1500)
    end
  end
  
  # callback events
  private
  # before save
  def before_save
    if self.comment_count < 0
      self.comment_count = 0
    end
  end
  
  # before validation
  def before_validation
    self.slug = self.slug.safe_slug
  end
  
  
  # custom method
  public
  # list
  def self.find_list(page = 1, per_page = 20,options = {})
    with_scope :find => options do
      paginate :page => page,:per_page => per_page, :order => 'created_at desc'
    end
  end
  
  def self.find_list_with_front(page = 1, per_page = 5, options = {})
    with_scope :find => options do
      find_list(page, per_page,:conditions => ["status = 1"])
    end
  end
  
  # find posts order by comment_count
  def self.find_hot(size = 10, options = {})
    with_scope :find => options do
      paginate :page => 1,:per_page => size, :conditions => ["status = 1"] , :order => 'comment_count desc'
    end
  end
  
  # find recent posts
  def self.find_recent(size = 10, options = {})
    with_scope :find => options do
      paginate :page => 1,:per_page => size, :conditions => ["status = 1"] , :order => 'created_at desc'
    end
  end
  
  # show
  def self.find_slug(slug)
    find_by_slug_and_status(slug,1)
  end
  
  
  # static method
  def self.update_view_count(slug)
    delay = 10
    cache_key = "data/posts/view_count/#{slug}"
    count = Rails.cache.read(cache_key).to_i || 0
    if count % delay == 0 && count != 0
      post = find_by_slug(slug)
      if post
        post.view_count += count + 1
        post.save
      end
      count = 0
    else
      count += 1
    end
    Rails.cache.write(cache_key,count)  
    count
  end
end
