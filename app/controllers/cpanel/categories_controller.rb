# coding: utf-8 
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
  end
  
  # GET /posts/new
  # GET /posts/new.xml
  def new
    @category = Category.new
    render :action => "edit"
  end

  # GET /posts/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /menus
  # POST /menus.xml
  def create
    @category = Category.new(params[:category])

    if @category.save
      flash[:notice] = '分类创建成功.'
      redirect_to(cpanel_categories_path)
    else
      render :action => "edit"
    end
  end

  # PUT /menus/1
  # PUT /menus/1.xml
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = '分类修改成功.'
      redirect_to(cpanel_categories_path)
    else
      render :action => "edit"
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to(cpanel_categories_path)
  end
end
