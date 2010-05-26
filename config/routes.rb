ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"  

  # Control Panel 
  map.namespace(:cpanel) do |cpanel|
    cpanel.root :controller => "home"  
    cpanel.login "login",:controller => "home", :action => "login" 
    cpanel.logout "logout",:controller => "home", :action => "logout" 
    
    cpanel.posts_importblogbus "posts/importblogbus", :controller => "posts", :action => "importblogbus"
    # modify password
    cpanel.settings_password "settings/password", :controller => "settings", :action => "password"

    cpanel.resources :menus,:pages,:posts,:comments,:settings,:categories   
    
  end
  
  # Share
  
  # Blog
  map.blogs "blog", :controller => "posts"
	map.blogs_page "blog/page/:page", :controller => "posts", :action => "index", :requirements => { :page => /[\d]+/ }
  map.blogs_rss "blog/rss", :controller => "posts", :action => "rss"
	map.blogs_category "blog/category/:category", :controller => "posts", :action => "index", :requirements => { :category => /[a-z0-9A-Z\-\_\.]+/ }
	map.blogs_category_page "blog/category/:category/:page", :controller => "posts", :action => "index", :requirements => { :category => /[a-z0-9A-Z\-\_\.]+/,:page => /[\d]+/ }  
	map.blogs_tag "blog/tag/:tag", :controller => "posts", :action => "index", :requirements => { :tag => /.+?/ }
	map.blogs_tag_page "blog/tag/:tag/:page", :controller => "posts", :action => "index", :requirements => { :tag => /.+?/,:page => /[\d]+/ }  
  map.blog "blog/:slug", :controller => "posts", :action => "show", :requirements => { :slug => /[a-z0-9A-Z\-\_\.]+/ }
 
  map.share "share", :controller => "home", :action => "share"
 
  map.unfollow "unfollow", :controller => "home", :action => :unfollow
  
  # Pages (This well be stay last line)
  map.page ":slug", :controller => "home", :action => "show", :requirements => { :slug => /[a-z0-9A-Z\-\_\.]+/ }
  
  # base routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
