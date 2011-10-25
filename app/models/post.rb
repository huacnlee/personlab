# coding: utf-8 
require "string_extensions"
class Post < ActiveRecord::Base
  validates_uniqueness_of :title, :slug, :case_sensitive => false , :message => "已经有同名的存在,请检查是否重发了."
  validates_presence_of :title,:body,:status
	belongs_to :category, :counter_cache => true
  acts_as_taggable_on :tags
  default_scope :order => 'posts.id desc'
  
  # callback events
  before_validation :safe_slug_validation
  
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
  
  # body summary
  def summary
    @sumarry_mark = "<!--{/summary}-->"
    if body.index(@sumarry_mark)
      body.split(@sumarry_mark)[0]
    else
      body.truncate_html(250,'')
    end
  end
    
  # cache delayed view_count
  def delay_view_count
    cache_key = "data/posts/view_count/#{slug}"
    Rails.cache.read(cache_key).to_i || 0
  end
  
  
  # before validation
  def safe_slug_validation
    self.slug = self.slug.safe_slug
  end
  
  
  # custom method
  public
	def self.find_list_with_front_by_tag(page = 1, per_page = 5,tag = '', options = {})
    tagged_with(tag,:on => :tags).paginate(:page => page,:per_page => per_page,    
      :include => [:tags,:category],
      :conditions => ["status =1"])
  end

  # show
  def self.find_slug(slug)
    p = Rails.cache.read("models/posts/#{slug}")
    if not p
      p = find_by_slug_and_status(slug,1)
      Rails.cache.write("models/posts/#{slug}",p)
    end
    return p
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
  
  
  
  def self.destroy_all
    all.each do |p|
      p.destroy
    end
  end
end
