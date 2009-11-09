class MenuSweeper < ActionController::Caching::Sweeper
  observe Menu
  
  def after_save(menu)
    clear_menu_cache(menu)
  end
  
  def after_destroy(menu)
    clear_menu_cache(menu)
  end
  
  def clear_menu_cache(menu)
    Rails.cache.delete("data/menus")
  end
end
