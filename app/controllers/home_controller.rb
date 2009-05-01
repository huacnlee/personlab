require "Fanfou"
class HomeController < ApplicationController
  caches_page :show
  
  def index
    set_seo_meta(nil,:keywords => @setting.meta_keywords,:desc => @setting.meta_description)
    set_nav_actived("home")
    
    # get fanfou messages
    if !@setting.fanfou_id.blank?
      fanfou = Fanfou::FanfouAPI.new    
      @fanfou_msgs = Rails.cache.read("data/fanfou/me")
      if @fanfou_msgs.blank?
        @fanfou_result = fanfou.show_user_messages(:id => @setting.fanfou_id)
        @fanfou_xml = ''
        @fanfou_result.each {|l| @fanfou_xml += l}
        @fanfou_msgs = Hash.from_xml(@fanfou_xml)["statuses"]["status"][0..4]
        Rails.cache.write("data/fanfou/me",@fanfou_msgs)
      end
    end
    
    if !fragment_exist? "home/index/recent_posts"
      @recent_post = Post.find(:first,:order => "created_at desc")
    end
  end

  def show
    @page = Page.find_show(params[:slug])
    
    if not @page
      render_404
      return
    end
    set_seo_meta(@page.title)
    set_nav_actived(@page.slug)
    render :file => "pages/show", :layout => "application"
  end
end
