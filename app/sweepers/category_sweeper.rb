class CategorySweeper < ActionController::Caching::Sweeper
  observe Category
  
  def after_save(category)
    clear_category_cache(category)
  end
  
  def after_destroy(category)
    clear_category_cache(category)
  end
  
  def clear_category_cache(category)
    Rails.cache.delete("data/categories")
		expire_fragment %r"posts/index/*"
		for p in category.posts do
			Rails.cache.write("data/posts/#{p.slug}",nil)
		end
  end
end
