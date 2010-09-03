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
    sweeper(comment)
  end
  
  def after_destroy(comment)
    sweeper(comment)
  end
  
  def sweeper(comment)
    clear_post_comments(comment)
  end
  
  # 清除评论列表
  def clear_post_comments(comment)
    if comment.post
      expire_fragment "posts/show/#{comment.post.slug}/comments"
    end
  end
end
