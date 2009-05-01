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
  
  def before_destroy(comment)
    clear_comment_cache(comment)
  end
  
  def clear_comment_cache(comment)
    expire_fragment %r"posts/index/*"
    expire_fragment "posts/show/#{comment.post.slug}/comments"
  end
end
