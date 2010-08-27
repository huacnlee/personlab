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
    
    @guest = { :author => cookies[:guest_author],:email => cookies[:guest_email],:url=> cookies[:guest_url]}

    if @guest.blank?
      @guest = set_guest
    end
  end

  # 输出404错误
  def render_404
    render_optional_error_file(404)
  end
  
  # 设置主菜单的活动标签
  def set_nav_actived(name = "home")
    @nav_actived = name
  end
  
  # 设置SEO 的Meta 值
  def set_seo_meta(title,keywords = '',desc = '')
    if title
      @page_title =  "#{title} &raquo; #{@setting.site_name}"
    else
      @page_title = @setting.site_name
    end
    @meta_keywords = keywords
    @meta_description = desc
  end
  
  # 保存评论者信息
  def set_guest(author = "",url = "",email = "")
    cookies[:guest_author] = { :value => author, :expires => 1.month.from_now } 
    cookies[:guest_url] = { :value => url, :expires => 1.month.from_now } 
    cookies[:guest_email] = { :value => email, :expires => 1.month.from_now } 
 	end
  
end
