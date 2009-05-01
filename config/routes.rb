ActionController::Routing::Routes.draw do |map|

  map.root :controller => "home"  

  # Control Panel 
  map.namespace(:cpanel) do |cpanel|
    cpanel.root :controller => "home"  
    cpanel.login "login",:controller => "home", :action => "login" 
    cpanel.login "logout",:controller => "home", :action => "logout" 
    
    cpanel.resources :menus,:pages,:posts,:comments,:settings
  end
  
  # Share
  map.resources :controller => "shares", :as => "share"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  # Blog
  map.purchase "blog", :controller => "posts"
  map.purchase "blog/:slug", :controller => "posts", :action => "show", :requirements => { :slug => /[a-z0-9A-Z\-\_\.]+/ }
  
  # Pages (This well be stay last line)
  map.purchase ":slug", :controller => "home", :action => "show", :requirements => { :slug => /[a-z0-9A-Z\-\_\.]+/ }

  
end
