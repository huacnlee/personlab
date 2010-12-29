# XML-RPC protocol support clone with Wordpress
# API interface: http://codex.wordpress.org/XML-RPC_wp  
require 'xmlrpc/server'
class XmlrpcController < ActionController::Base

  def initialize
    @server = XMLRPC::BasicServer.new
    # loop through all the methods, adding them as handlers
    self.class.instance_methods(false).each do |method|      
      if not ['index','rsd'].index(method.to_s)
        logger.debug "------ in #{method}" 
        @server.add_handler("wp.#{method.to_s}") do |*args| 
          self.send(method.to_sym, *args)
        end        
      end
    end
    @setting = Setting.find_create    
  end
  
    
  def index
    if !params[:rsd].blank?
      return rsd
    end
    
    result = @server.process(request.body)
    logger.info "\n\n----- BEGIN RESULT -----\n#{result}\n----- END RESULT -----\n"
    render :text => result, :content_type => 'text/xml'
  end
  
  private
  def rsd
    render "rsd", :layout => false
  end

  public
  def getUsersBlogs(username,password)
    logger.debug "------ in getUsersBlogs"
    if user = User.check_login(username,User.encode(password))
      array = [{
        'isAdmin' => true,
        'url' => root_url,
        'blogid' => 1,
        'blogName' => @setting.site_name,
        'xmlrpc' => xmlrpc_url
        }] 
      return array 
    else
      render :status => 403
    end    
  end
  
  def getTags(blog_id,username,password)
    tags = Tag.all
    result = []
    tags.each do |tag|
      result << { 
        'tag_id' => tag.id,
        'name' => tag.name,
        'count' => 0,
        'slug' => tag.name,
        'html_url' =>tag_blogs_url(tag.name),
        'rss_url' => ''
      }
    end
    return result
  end
end