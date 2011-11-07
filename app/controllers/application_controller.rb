# coding: utf-8 
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :init
  
  # 初始化
  def init
    @menus = Menu.find_all
    
    @setting = Setting.find_create
  end
  
  # 输出404错误
  def render_404
    render(:file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404)
    return
  end
  
  # 设置主菜单的活动标签
  def set_nav_actived(name = "home")
    @nav_actived = name
  end
  
  # 设置SEO 的Meta 值
  def set_seo_meta(title,keywords = '',desc = '')
    if title
      @page_title =  "#{title}"
      if params[:page]
        @page_title += " &raquo; (第#{params[:page]}页)"
      end
      @page_title += " &raquo; #{@setting.site_name}"
    else
      @page_title = @setting.site_name
    end
    @meta_keywords = keywords
    @meta_description = desc
  end
end
