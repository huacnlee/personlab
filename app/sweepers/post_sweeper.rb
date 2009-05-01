class PostSweeper < ActionController::Caching::Sweeper
  observe Post
  
  def after_update(post)
    clear_post_cache(post)
  end
  
  def after_create(post)
    clear_index_recent_posts_cache
  end
  
  def after_destroy(post)
    clear_post_cache(post)
  end
  
  def clear_post_cache(post)
    clear_index_recent_posts_cache
    expire_fragment %r"posts/index/*"
    Rails.cache.write("data/posts/#{post.slug}",nil)
    expire_fragment "posts/show/#{post.slug}/comments"
  end
  
  def clear_index_recent_posts_cache
    expire_fragment "home/index/recent_posts"
  end
  
end
