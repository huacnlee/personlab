# ----------------------------------------------------
# name: comment_speeper.rb
# authors: Jason Lee<huacnlee@gmail.com>,
# create at: 2009-04-20
# summary:
#   this comment_speeper.rb summary
# ----------------------------------------------------
class CommentSweeper < ActionController::Caching::Sweeper
  observe Comment
  
  def after_create(comment)
    clear_comment_cache(comment)
  end
  
  def after_destroy(comment)
    clear_comment_cache(comment)
  end
  
  def clear_comment_cache(comment)
    expire_fragment %r"posts/index/*"
    expire_fragment "posts/show/#{comment.post.slug}/comments"
    clear_posts_sidebar(comment)
  end
  
  # 清除 posts controller 的 sidebar 缓存
  def clear_posts_sidebar(comment)
    expire_fragment 'posts/sidebar/recent_comments'
    expire_fragment 'posts/sidebar/hot_posts'    
  end
end
