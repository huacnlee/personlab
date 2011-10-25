class PostSweeper < ActionController::Caching::Sweeper
  observe Post
  
  def after_update(post)
    sweeper(post)
  end
  
  def after_create(post)
    clear_index_recent_posts
		sweeper(post)
  end
  
  def after_destroy(post)
		clear_index_recent_posts
    sweeper(post)
  end
  
  def sweeper(post)
    clear_index_recent_posts
    expire_page "/blog/rss"
    Rails.cache.delete("models/posts/#{post.slug}")
		Rails.cache.delete("data/categories")
		Rails.cache.touch_tag("posts_list")
  end
  
  # 清除首页缓存
  def clear_index_recent_posts
    expire_fragment "home/index/recent_posts"
  end
  
end
