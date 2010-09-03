# coding: utf-8 
class PostsController < ApplicationController
  cache_sweeper :comment_sweeper,:only => [:show]
  validates_captcha
  before_filter :init_posts
  
  private
  def init_posts
    set_nav_actived("blog")
  end
  
  public
  def index		
    if params[:search]      
      set_seo_meta("#{params[:search]}的搜索结果")
		elsif params[:category]
			@category = Category.find_by_slug(params[:category])
			if not @category
				render_404
				return
			end
			if not params[:page]
        set_seo_meta("博客 &raquo; 分类：#{@category.name}")
      else
        set_seo_meta("博客 &raquo; 分类：#{@category.name} &raquo; 第#{params[:page]}页")
      end
		elsif params[:tag]
			if not params[:page]
        set_seo_meta("博客 &raquo; Tag:#{params[:tag]}")
      else
        set_seo_meta("博客 &raquo; Tag:#{params[:tag]} &raquo; 第#{params[:page]}页")
      end
    else
			if not params[:page]
        set_seo_meta("博客")
      else
        set_seo_meta("博客 &raquo; 第#{params[:page]}页")
      end
    end

    page = params[:page] ? params[:page] : 1
		per_page = 5
    if params[:search] 
      @cache_key = "posts/index/search/#{params[:search]}/#{page}"
			if !fragment_exist? @cache_key
	      @posts = Post.find_list_with_front(params[:page],per_page,:conditions => ['title like ? or body like ? or meta_keywords like ?',"%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%"])
	    end
		elsif params[:category]
			@cache_key = "posts/index/category/#{params[:category]}/#{page}"
			if !fragment_exist? @cache_key
				@posts = Post.find_list_with_front(params[:page],per_page,:conditions => ['categories.slug = ?',params[:category]])
			end
		elsif params[:tag]
			@cache_key = "posts/index/category/#{params[:tag]}/#{page}"
			if !fragment_exist? @cache_key
				@posts = Post.find_list_with_front_by_tag(page,per_page,params[:tag])
			end
    else
      @cache_key = "posts/index/#{page}"
			if !fragment_exist? @cache_key
	      @posts = Post.find_list_with_front(params[:page],per_page)
	    end
    end 
  end


  
  def rss
		@cache_key = "posts/index/feed"
		if !fragment_exist? @cache_key
   	 # Get the 10 most recent photos
	    @posts = Post.find_list_with_front(1,20)
	    # Title for the RSS feed
	    @feed_title = "10 most recent photos"
	    # Get the absolute URL which produces the feed
	    @feed_url = "http://" + request.host_with_port + request.request_uri
	    # Description of the feed as a whole
	    @feed_description = "20 most recent posts"
		end
    # Set the content type to the standard one for RSS
    response.headers['Content-Type'] = 'application/rss+xml'
    # Render the feed using an RXML template
    render :action => 'rss', :layout => false
  
  end
  
  def show
    @post_key = "data/posts/#{params[:id]}"
    # update pv    
        
    @view_count = Post.update_view_count(params[:id])
    
    if (not @post) or (@view_count == 0)
      @post = Post.find_slug(params[:id])
      if not @post
        return render_404
      end
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
  
end

