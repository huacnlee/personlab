# coding: utf-8 
# admin home controller
class Cpanel::HomeController < Cpanel::ApplicationController
  before_filter :require_login,:only => [:index,:logout]
  
  # cpanel
  def index
    @total = {}
    @total[:post_count] = Post.count
    @total[:page_count] = Page.count

    @recent_posts = Post.limit(5)
  end
  
  # cpanel/logout
  def logout
    clear_login
    redirect_to :controller => "/home", :action => "index"
  end
  
  # cpanel/login
  def login
    @user = User.new
    
    if params[:user]
      @user = User.check_login(params[:user][:uname], User.encode(params[:user][:pwd]))
      if @user
        save_login(@user)
        redirect_to :controller => "/cpanel"
        return
      else
        @user = User.new
        flash[:errors] = "用户名或密码不正确。"
      end
    end
    
    render :action => "login", :layout => false
  end
  
end
