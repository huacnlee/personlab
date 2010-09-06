# coding: utf-8 
class Cpanel::SettingsController < Cpanel::ApplicationController
  cache_sweeper :setting_sweeper,:page_sweeper, :only => [:update]
  
  # GET /settings
  # GET /settings.xml
  def index
    @setting = Setting.find_create

    if request.put?
      if @setting.update_attributes(params[:setting])
        save_notice("设置修改成功.")
        redirect_to :controller => "settings"
      else
        render :action => "index"
      end
    end
  end
  
  def update
  end

  def password
    if request.put?
      if @current_user.update_pwd(params[:old_pwd], params[:new_pwd], params[:confirm_pwd])
        save_notice("密码修改成功。")
        redirect_to :action => "password"
      end
    end
  end
  
  def profile
    if request.put?
      pu = params[:user]
      @current_user.uname = pu[:uname]
      @current_user.name = pu[:name]
      @current_user.email = pu[:email]
      if @current_user.save
        save_notice("管理员信息修改成功。")
        redirect_to :action => "profile"
      end
    end
  end

end
