# coding: utf-8 
class HomeController < ApplicationController
  caches_action :show
  caches_action :share, :cache_path =>  Proc.new { |c| "home/share/#{Time.now.to_date.to_s}" }
  
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
  
  def guest_login
    session[:last_page] = params[:url]
    redirect_to "/auth/google"
  end
  
  def auth_callback
    auth = request.env["omniauth.auth"]
    first_name = auth['user_info']['first_name']
    last_name = auth['user_info']['last_name']
		if /[a-zA-Z]/.match(first_name)
			name = auth['user_info']['name']
		else
			name = "#{last_name.strip}#{first_name.strip}"
		end
    email = auth['user_info']['email']
    login = email.split('@').first
    set_guest(name,"https://www.google.com/profiles/#{login}",email)
    last_page = session[:last_page]
    session[:last_page] = nil
    redirect_to last_page
  end
  
  def auth_failure
    render_404
  end
  
  def auth_destroy
    set_guest
    @current_user = nil
    session[:user_id] = nil
    redirect_to request.referer
  end
end
