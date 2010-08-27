# coding: utf-8 
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Cpanel::ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  layout "cpanel"
  
  before_filter :check_login
  
  def require_login
    if not @current_user
      redirect_to :controller => "cpanel/home", :action => "login"
      return
    end
  end
  
  def save_notice(notice)
    flash[:notice] = notice
  end
  
  def save_login(user)
    session[:user_id] = user.id
    @current_user = User.find_by_id(session[:user_id])    
  end
  
  def clear_login
    @current_user = nil
    session[:user_id] = nil
  end
  
  def check_login
    @current_user = User.find_by_id(session[:user_id])
  end
end
