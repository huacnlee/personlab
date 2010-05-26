class HomeController < ApplicationController
  caches_action :show
  
  def index
    set_seo_meta(nil,@setting.meta_keywords,@setting.meta_description)
    set_nav_actived("home")

    # get fanfou messages
    @fanfou_msgs = []
    if !@setting.fanfou_id.blank? and TWITTER_ENABLE
      # @tweets = []
      @tweets = Tweet.get_home_messages(@setting.fanfou_id,5)
    end
    
    if !fragment_exist? "home/index/recent_posts"
      @recent_posts = Post.find(:all, :limit => 13,:order => "created_at desc")
    end
    
    if !fragment_exist? "home/index/recent_comments"
      @recent_comments = Comment.find_recent(3)
    end
  end

  def show
    @page = Page.find_show(params[:slug])
    
    if not @page
      render_404
      return
    end
    set_seo_meta(@page.title)
    set_nav_actived(@page.slug)
    render :file => "pages/show", :layout => "application"
  end
  
  def share
    set_nav_actived("share")
    set_seo_meta("Google Reader 分享")
    @api_url = Share.api_url(@setting)
    @shares = Share.find_all(@setting)
  end
  
  # unfollow for email notice
  # type  Model
  # id    Model id
  # key   email encode key
  def unfollow
    return render_404  if params[:type].blank? or params[:id].blank? or params[:key].blank?
    email = Encoder.decode(params[:key])
    return render_404 if email.blank?

    Unfollower.create(:email => email, 
                      :unfollowerable_type => params[:type].capitalize, 
                      :unfollowerable_id => params[:id].to_i)
                      
    render :text => "你已经成功退定."
  end
end
