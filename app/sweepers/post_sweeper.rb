class PostSweeper < ActionController::Caching::Sweeper
  observe Post
  
  def after_update(post)
    sweeper(post)
  end
  
  def after_create(post)
    clear_index_recent_posts
  end
  
  def after_destroy(post)
    sweeper(post)
  end
  
  def sweeper(post)
    clear_index_recent_posts
    expire_fragment %r"posts/index/*"
    Rails.cache.write("data/posts/#{post.slug}",nil)
    clear_post_comments(post)
  end
  
  # 清除评论列表
  def clear_post_comments(post)
    expire_fragment "posts/show/#{post.slug}/comments"
  end
  
  # 清除首页缓存
  def clear_index_recent_posts
    expire_fragment "home/index/recent_posts"
    expire_fragment 'posts/sidebar/recent_posts'
  end
  
end
