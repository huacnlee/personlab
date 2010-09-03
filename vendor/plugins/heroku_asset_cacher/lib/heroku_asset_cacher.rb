class HerokuAssetCacher
  def initialize_asset_packager
    $asset_cache_base_path = heroku_file_location  
  end
  
  def initialize(app)
    @app = app
    initialize_asset_packager if ActionController::Base.perform_caching
    @@regex_css = /\/stylesheets\/cached_([\w]+).css/i
    @@regex_js =  /\/javascripts\/cached_([\w]+).js/i
  end
  
  def call(env)
		@env = env
		if ActionController::Base.perform_caching
			return render_css if env['PATH_INFO'] =~ @@regex_css
			return render_js if env['PATH_INFO'] =~ @@regex_js
		end
    
		@app.call(env)
  end
  
  def render_js
    file_name = @@regex_js .match(@env['PATH_INFO'])[1]
		file = "#{heroku_file_location}/cached_#{file_name}.js"
			[
				200,
				{
				'Cache-Control'  => 'public, max-age=86400',
				'Content-Length' => File.size(file).to_s,
				'Content-Type'   => 'text/javascript'
				},
				File.read(file)
			]
  end
  
  def render_css
    file_name = @@regex_css.match(@env['PATH_INFO'])[1]
		file = "#{heroku_file_location}/cached_#{file_name}.css"
			[
				200,
				{
				'Cache-Control'  => 'public, max-age=86400',
				'Content-Length' => File.size(file).to_s,
				'Content-Type'   => 'text/css'
				},
				File.read(file)
			]
  end
  
	def heroku_file_location
		"#{RAILS_ROOT}/tmp/asset_cache"
	end
	
end