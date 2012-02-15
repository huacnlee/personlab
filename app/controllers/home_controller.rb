# coding: utf-8 
class HomeController < ApplicationController
  caches_page :show
  caches_action :share, :cache_path =>  Proc.new { |c| "home/share" }, :expires_in => 1.days
  
  def index
    set_seo_meta(nil,@setting.meta_keywords,@setting.meta_description)
    set_nav_actived("home")

    # get fanfou messages
    if !@setting.twitter_id.blank?
      @tweets = []
      begin
        @tweets = Tweet.gets(@setting.twitter_id,5)
      rescue => e
        logger.error { "Home twitter load failed: #{e}" }
      end
    end
    
    if !fragment_exist? "home/index/recent_posts"
      @recent_posts = Post.publish.limit(13).where(:status => 1)
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
  
  def twitter
    set_nav_actived("twitter")
    set_seo_meta("我的 Twitter")
    @tweets = Tweet.gets(@setting.twitter_id,20)
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
