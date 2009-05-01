class PageSweeper < ActionController::Caching::Sweeper
  observe Page
  
  def after_save(page)
    clear_page_cache(page)
  end
  
  def after_destroy(page)
    clear_page_cache(page)
  end
  
  def clear_page_cache(page)
    expire_page :controller => "/home", :action => "show", :slug => page.slug
  end
  
  def clear_all()
    expire_page :controller => "/home", :action => "show"
  end
end
