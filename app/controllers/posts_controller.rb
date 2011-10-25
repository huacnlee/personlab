# coding: utf-8 
class PostsController < ApplicationController
  caches_page :rss, :depends => ["posts_list"]
  caches_action :index,
    :cache_path =>  Proc.new { |c| "blog/index/#{c.request.params[:page]}:#{c.request.params[:category]}:#{c.request.params[:tag]}" },
    :depends => ["posts_list"]
  cache_sweeper :comment_sweeper,:only => [:show]
  validates_captcha
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
      
      @posts = @category.posts.paginate :include => [:category],:page => page, :per_page => 5
      set_seo_meta("博客 &raquo; 分类：#{@category.name}")        
    elsif params[:tag]    
      @posts = Post.tagged_with(params[:tag]).paginate :include => [:category],:page => page, :per_page => 5
      set_seo_meta("博客 &raquo; Tag:#{params[:tag]}")
    else      
      @posts = Post.paginate :include => [:category], :page => page, :per_page => 5            
      set_seo_meta("博客")
    end
  end


  
  def rss
    # Get the 10 most recent photos
    @posts = Post.paginate :include => [:category], :page => 1, :per_page => 20
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
 
    if request.post?
      @comment = Comment.new(params[:comment])
      @comment.post_id = @post.id
      
			set_guest(@comment.author,@comment.url,@comment.email)  
      if captcha_validated?
        if @comment.save
          NoticeMailer.new_comment_notice(@post,@comment)
          if @comment.status == 2
            flash[:notice] = "评论发表成功。<br />但由于经过 Akismet 自动判定，您的评论内容需要由管理人员审核过后方可显示。"
          else
            flash[:notice] = "评论发表成功."
          end          
          redirect_to blog_path(@post.slug), :anchor => "comment"
        end
      else
        @comment.errors.add("验证码","不正确")
      end
    else
      @comment = Comment.new
      @comment.author = @guest[:author]
      @comment.url = @guest[:url]
      @comment.email = @guest[:email]
    end
    
    set_seo_meta(@post.title,@post.meta_keywords,@post.meta_description)
    
    # get comments list
    if !fragment_exist? "posts/show/#{params[:id]}/comments"
      @comments = @post.comments
    end
   
  end
  
  def comments
    @comments = Comment.all
    @posts = Post.unscoped.order("id asc")
    render :layout => false
  end
  
end

