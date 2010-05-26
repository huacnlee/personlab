class NoticeMailer < ActionMailer::Base
  helper :application
  layout "mailer"
  def new_comment_notice(post,new_comment,comment,setting)
    subject "[#{setting.site_name}网站评论提醒] - #{post.title}"
    recipients comment.email
    from "no-reply@#{APP_DOMAIN}"
    sent_on Time.now
    body_array = {:post => post, :new_comment => new_comment, :comment => comment, :setting => setting}
    body body_array
    template "new_comment_notice"
  end
  
  def self.new_comment_notice(post,new_comment)
    # Thread.new {
      setting = Setting.find_create
    
      # 找出不重复的评论,并带有Email的
      comments = []
      mails = []
      post.comments.all.collect do |c| 
        if !mails.index(c.email) and !c.email.blank? and (c.email != new_comment.email)
          comments << c
          mails << c.email
        end
      end
    
      comments.each do |comment|
        if !Unfollower.exist(comment.email,post)
          NoticeMailer.deliver_new_comment_notice(post,new_comment,comment,setting)
        end
      end
    # }
  end

end
