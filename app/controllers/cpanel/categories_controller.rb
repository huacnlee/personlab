# ----------------------------------------------------
# name: menus_controller.rb
# authors: Jason Lee<huacnlee@gmail.com>,
# create at: 2009-04-16
# summary:
#   cpanel menu controller
# ----------------------------------------------------

class Cpanel::CategoriesController < Cpanel::ApplicationController
  before_filter :require_login

	cache_sweeper :category_sweeper, :only => [:create,:update,:destroy]
  
  # GET /menus
  # GET /menus.xml
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menus }
    end
  end
  
  # GET /posts/new
  # GET /posts/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @menu }
    end
  end

  # GET /posts/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /menus
  # POST /menus.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = '分类创建成功.'
        format.html { redirect_to(cpanel_categories_url) }
        format.xml  { render :xml => @menu, :status => :created, :location => @menu }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = '分类修改成功.'
        format.html { redirect_to(cpanel_categories_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_categories_url) }
      format.xml  { head :ok }
    end
  end
end
