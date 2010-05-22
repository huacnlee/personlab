class Cpanel::PostsController < Cpanel::ApplicationController
  cache_sweeper :post_sweeper,:only => [:create,:update,:destroy]
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.find_list(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  
  # GET show import form blogbus
  # POST do import form blogbus
  def importblogbus
    require "lib/importer/blog_bus"
    if request.post?
      file_name = params[:file_name]
      is_clear = params[:clear_old_date]
      logger.debug { "#{is_clear}" }
      if is_clear == "on"
        Post.destroy_all
        Tag.all.each{ |t| t.destroy }
      end
      
      # import posts
      datas = BlogBus.read_backup(file_name)
      datas.each do |d|        
        post = Post.new()
        post.created_at = d.elements['LogDate'].text.to_time
        post.updated_at = post.created_at
        post.title = d.elements['Title'].text
        post.slug = post.created_at.to_s('%y%m%d%H%M%S')
        post.body = d.elements['Content'].text
        post.status = d.elements['Status'].text
        # import tags
        if d.elements['Tags'].text
          tags = d.elements['Tags'].text.split(' ')
          tags.each do |t|
            tag = Tag.new(:name => t)
            post.tags << tag
          end
        end
        post.save
        
        # import comments
        dcomments = d.elements['Comments']
        dcomments.each do |c|
          comment = Comment.new
          comment.post = post
          comment.status = 1
          comment.email = c.elements['Email'].text
          comment.url = c.elements['HomePage'].text
          comment.created_at = c.elements['CreateTime'].text.to_time
          comment.updated_at = comment.created_at
          comment.author = c.elements['NiceName'].text
          comment.body = c.elements['CommentText'].text
          comment.save
        end
      end
    else
      render :action => "importblogbus"
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
