# coding: utf-8 
# ----------------------------------------------------
# name: pages_controller.rb
# authors: Jason Lee<huacnlee@gmail.com>,
# create at: 
# summary:
#   CPanel Pages Controller
# ----------------------------------------------------
class Cpanel::PagesController < Cpanel::ApplicationController
  before_filter :require_login
  
  cache_sweeper :page_sweeper,:only => [:create,:update,:destory]
  
  # 页面列表
  def index
    @pages = Page.paginate :page => params[:page], :per_page => 20, :order => 'id desc'
  end  
  
  # 创建页面
  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @page }
    end
  end

  
  # 修改页面
  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # 提交页面信息
  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        save_notice("页面创建成功,可以 <a href=\"#{page_path(@page.slug)}\" target=\"_blank\">点击这里</a> 查看.")
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # 更新页面
  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        save_notice("页面修改成功,可以 <a href=\"#{page_path(@page.slug)}\" target=\"_blank\">点击这里</a> 查看.")
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # 删除页面
  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      save_notice("页面已经删除.")
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end
end
