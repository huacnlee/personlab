class Cpanel::SettingsController < Cpanel::ApplicationController
  cache_sweeper :setting_sweeper,:page_sweeper, :only => [:update]
  
  # GET /settings
  # GET /settings.xml
  def index
    @setting = Setting.find_create
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = Setting.find(params[:id])

    if @setting.update_attributes(params[:setting])
      save_notice("设置修改成功.")
      redirect_to :controller => "settings"
    else
      render :action => "index"
    end
  end

end
