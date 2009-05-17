class PostsController < ApplicationController
  cache_sweeper :comment_sweeper,:only => [:show]
  before_filter :init_posts
  
  private
  def init_posts
    set_nav_actived("blog")
  end

  def init_sidebar
    if !fragment_exist? "posts/sidebar/hot_posts"
      @hot_posts = Post.find_hot
    end

    if !fragment_exist? "posts/sidebar/recent_posts"
      @recent_posts = Post.find_recent
    end

    if !fragment_exist? "posts/sidebar/recent_comments"
      @recent_comments = Comment.find_recent
    end
  end
  
  public
  def index
    set_seo_meta("博客")
    if !fragment_exist? "posts/index/#{params[:page]}"
      @posts = Post.find_list_with_front(params[:page])
    end
    
    init_sidebar
  end
  
  def rss
    # Get the 10 most recent photos
    @posts = Post.find_list_with_front(1,20)
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
    @view_count_delay = 10
    @post_key = "data/posts/#{params[:slug]}"
    @view_count_key = "data/posts/#{params[:slug]}/view_count_delay"
    @view_count = 0
    
    # update pv
    @view_count = Rails.cache.read(@view_count_key).to_i || 0
    if @view_count % @view_count_delay == 0 && @view_count != 0
      Post.update_view_count(params[:slug],@view_count)
      @view_count = 0
    else
      @view_count += 1
    end
    Rails.cache.write(@view_count_key,@view_count)
    
    @post = Rails.cache.read(@post_key)
    if (not @post) or (@view_count == 0)
      @post = Post.find_slug(params[:slug])
      if not @post
        return render_404
      end
      
      Rails.cache.write(@post_key,@post)
    end
    
    if request.post?
      # post comment
      @pcomment = params[:comment]
      @comment = Comment.new(params[:comment])
      @comment.post_id = @post.id
      @comment.status = 1

      set_guest(@comment.author,@comment.url,@comment.email)

      if @comment.save
        flash[:notice] = "评论发表成功."
        redirect_to :action => "show", :slug => @post.slug, :anchor => "comment"
      end
    else
      @comment = Comment.new
      @comment.author = @guest[:author]
      @comment.url = @guest[:url]
      @comment.email = @guest[:email]
    end
    
    set_seo_meta(@post.title,@post.meta_keywords,@post.meta_description)
    
    # get comments list
    if !fragment_exist? "posts/show/#{params[:slug]}/comments"
      @comments = @post.comments.find_list
    end
   
  end
  
end
