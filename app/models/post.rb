# coding: utf-8 
require "string_extensions"
class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  belongs_to :category, :counter_cache => true
  
  validates_uniqueness_of :title, :slug, :case_sensitive => false , :message => "已经有同名的存在,请检查是否重发了."
  validates_presence_of :title,:body,:status
	
  # callback events
  before_validation :safe_slug_validation
  def safe_slug_validation
    self.slug = self.slug.safe_slug
  end
  
  # status
  STATUS = [
    ["请选择状态",-1],
    ["发布",1],
    ["草稿",2],
    ].freeze
  
  # scope
  default_scope :order => 'posts.id desc'
  scope :publish, where(:status => 1)
  
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
  
  def self.update_view_count(slug)
    delay = 10
    cache_key = "data/posts/view_count/#{slug}"
    count = Rails.cache.read(cache_key).to_i || 0
    if count % delay == 0 && count != 0
      post = find_by_slug(slug)
      if post
        post.view_count += count + 1
        Post.where(:id => post.id).update_all(:view_count => post.view_count)
      end
      count = 0
    else
      count += 1
    end
    Rails.cache.write(cache_key,count)  
    count
  end
end
