ActionController::Routing::Routes.draw do |map|
  root :controller => :home,:action => :index  
  # Control Panel 
  namespace 'cpanel' do
    root :controller => :home, :action => :index
    map.login "login", :controller => :home, :action => :login
    map.logout "logout", :controller => :home, :action => :logout

    resources :menus,:pages,:posts,:categories
    resources :settings, :only => [:index, :create] do
      collection do
        get :password
        post :password
        get :profile
        post :profile
      end
    end
  end
  
  # Blog
  resources :blogs, :controller => :posts, :path => "blog" do
    collection do
      get :category, :path => "category/:category", :action => :index
      get :rss    
    end
  end
  
  match "xmlrpc" => "xmlrpc#index"
 
  match "share" => "home#share"
  match "twitter" => "home#twitter"
  match "unfollow" => "home#unfollow"
  map.page ":slug", :controller => :home, :action => :show, :requirements => { :slug => /[a-z0-9A-Z\-\_\.]+/ }
  
  # base routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
