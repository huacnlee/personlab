class SettingSweeper < ActionController::Caching::Sweeper
  observe Setting
  
  def after_save(setting)
    clear_setting_cache(setting)
  end
  
  def clear_setting_cache(setting)
    Rails.cache.delete("models/setting")
  end
end
