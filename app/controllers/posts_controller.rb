# coding: utf-8 
class PostsController < ApplicationController
  caches_action :rss, :depends => ["posts_list"]
  caches_action :index,
    :cache_path =>  Proc.new { |c| "blog/index/#{c.request.params[:page]}:#{c.request.params[:category]}:#{c.request.params[:tag]}" },
    :depends => ["posts_list"]
  before_filter :init_posts
  
  private
  def init_posts
    set_nav_actived("blog")
  end
  
  public
  def index		
    page = params[:page] ? params[:page] : 1    
    if params[:category]
			@category = Category.find_by_slug(params[:category])
			if not @category
				render_404
				return
			end
      
      @posts = @category.posts.publish.paginate :include => [:category],:page => page, :per_page => 5
      set_seo_meta("博客 &raquo; 分类：#{@category.name}")        
    elsif params[:tag]    
      @posts = Post.tagged_with(params[:tag]).publish.paginate :include => [:category],:page => page, :per_page => 5
      set_seo_meta("博客 &raquo; Tag:#{params[:tag]}")
    else      
      @posts = Post.publish.paginate :include => [:category], :page => page, :per_page => 5            
      set_seo_meta("博客")
    end
  end


  
  def rss
    # Get the 10 most recent photos
    @posts = Post.publish.paginate :include => [:category], :page => 1, :per_page => 20
    # Title for the RSS feed
    @feed_title = "10 most recent photos"
    # Get the absolute URL which produces the feed
    @feed_url = "http://" + request.host_with_port + request.request_uri
    # Description of the feed as a whole
    @feed_description = "20 most recent posts"
    # Set the content type to the standard one for RSS
    response.headers['Content-Type'] = 'application/rss+xml'
    # Render the feed using an RXML template
    render :action => 'rss', :layout => false
  
  end
  
  def show
    # update pv    
        
    @view_count = Post.update_view_count(params[:id])
    
    @post = Post.find_slug(params[:id])
    if not @post
      return render_404
    end
    
    set_seo_meta(@post.title,@post.meta_keywords,@post.meta_description)
    
   
  end

  
end

