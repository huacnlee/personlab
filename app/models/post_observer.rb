# ----------------------------------------------------
# name: post_observer.rb
# authors: Jason Lee<huacnlee@gmail.com>,
# create at: 2009-04-20
# summary:
#   this post_observer.rb summary
# ----------------------------------------------------
class PostObserver < ActiveRecord::Observer
  
  def after_update(post)
    
  end

  def after_destroy(post)
    # destroy post.comments
    post.comments.each { |c| c.destroy() }
  end
end
