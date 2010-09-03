ActionController::Routing::Routes.draw do |map|
  root :controller => :home,:action => :index  

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
  
  # Blog
  resources :blogs, :controller => :posts, :path => "blog" do
    collection do
      get :category, :path => "category/:category", :action => :index
      get :tag, :path => "tag/:tag", :action => :index
    end
    member do
      post :comment, :path => "/comment", :action => :show
    end
  end
 
  match "share" => "home#share"
  match "unfollow" => "unfollow"
  map.page ":slug", :controller => :home, :action => :show, :requirements => { :slug => /[a-z0-9A-Z\-\_\.]+/ }
  
  # base routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
