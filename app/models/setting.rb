class Setting < ActiveRecord::Base
  def self.find_create
    @setting = first
    if not @setting
      @setting = new(:site_name => "李华顺", :sub_title => "这是一个用于介绍我的网站", 
        :meta_keywords => "李华顺,Jason Lee,huacnlee", 
        :email => "huacnlee@gmail.com",
        :meta_description => "我是一个Web开发人员,.NET,Python,Ruby,PHP,Javascrip等都有在用,我是做互联网开发的,这是一个用于介绍我自已的网站.",
        :fanfou_id => "huacn",
        :home_show => '
<div class="info">
  <div class="face">
		<img alt="李华顺的照片" src="/images/face.jpg">
	</div>
	<div class="feed">
		<a id="get_feed" href="#" title="订阅我的博客">
			<img alt="订阅我的博客" src="/images/feed_big.jpg">
		</a><br>
		<img alt="Email:huacnlee@gmail.com" src="/images/gmail_label.jpg">
	</div>
</div>
<div class="icons">
	<a href="http://fanfou.com/huacn" target="_blank" title="关注我的饭否"><img alt="我的饭否" src="/images/webicons/fanfou.jpg"></a>
	<a href="http://twitter.com/huacnlee" target="_blank" title="我的Twitter"><img alt="我的Twitter" src="/images/webicons/twitter.jpg"></a> <a href="http://www.xiami.com/u/8008" title="我的虾米音乐分享" target="_blank"><img alt="我的虾米音乐分享" src="/images/webicons/xiami.jpg"></a> 
	<a href="http://del.icio.us/huacnlee" target="_blank" title="我的Delicious收藏夹"><img alt="我的Delicious收藏夹" src="/images/webicons/delicious.jpg"></a> 
	<a href="http://www.douban.com/people/huacnlee/" target="_blank" title="我的豆瓣"><img alt="我的豆瓣" src="/images/webicons/douban.jpg"></a>
	<a href="http://huacnlee.stumbleupon.com/" style="display: none;" title="我的
	StumbleUpon"><img alt="simple" src="/images/webicons/stumbleupon.jpg"></a> 
	<a href="http://friendfeed.com/huacn" target="_blank" title="我的FriendFeed"><img alt="我的FriendFeed分享" src="/images/webicons/friendfeed.jpg"></a> 
	<a href="http://huacn.yupoo.com/" target="_blank" title="我的Yupoo相册"><img alt="我的Yupoo相册" src="/images/webicons/yupoo.jpg"></a> 
	<a href="http://flickr.com/photos/huacnlee" traget="_blank"><img alt="我的Flickr相册" src="/images/webicons/flickr.jpg"></a>
	<a href="http://picasaweb.google.com/huacnlee" title="我的Picasa相册"><img alt="我的Picasa相册" src="/images/webicons/picasaweb.jpg"></a> 
	<a href="http://www.youtube.com/huacnlee" target="_blank" title="我的Youtube收藏"><img alt="我的Youtube收藏" src="/images/webicons/youtube.jpg"></a> 
	<a href="http://cn.last.fm/user/huacnlee/" target="_blank" title="我的Last.fm"><img alt="我的Last.fm" src="/images/webicons/lastfm.jpg"></a> 
	<a href="http://wakoopa.com/huacnlee" title="我最常用的软件及评价(Wakoopa)"><img alt="我最常用的软件及评价(Wakoopa)" src="/images/webicons/wakoopa.jpg"></a>
</div>')
      @setting.save
    end
    @setting
  end
end
