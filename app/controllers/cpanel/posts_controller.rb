class Cpanel::PostsController < Cpanel::ApplicationController
  cache_sweeper :post_sweeper,:only => [:create,:update,:destory]
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.find_list(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find_by_slug(params[:slug])

    respond_to do |format|
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        save_notice("文章创建成功,可以 <a href=\"#{url_for(:controller => "/posts", :action => "show", :slug => @post.slug)}\" target=\"_blank\">点击这里</a> 查看")
        format.html { redirect_to :controller => "posts", :action => "index" }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        logger.debug { "post_update" }
        save_notice("文章修改成功,可以 <a href=\"#{url_for(:controller => "/posts", :action => "show", :slug => @post.slug)}\" target=\"_blank\">点击这里</a> 查看")
        format.html { redirect_to :controller => "posts", :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      save_notice("文章删除成功.")
      format.html { redirect_to(cpanel_posts_url) }
      format.xml  { head :ok }
    end
  end
end
