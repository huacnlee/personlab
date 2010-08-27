# coding: utf-8 
require'open-uri' 
require'net/http'  

#
# Fanfou.com API应用接口
# API 申请地址: http://groups.google.com/group/fanfou-api?pli=1
# 作者: ronghai.v@gmail.com
module  FanfouMoulde
  AVAILABLE_FORMAT=%w{xml json}
  FAN_FOU_HOST=["http://api.fanfou.com/"]  
  VERSION="0.0.1" 
  AUTHOR_EMAIL="ronghai.v@gmail.com"
  
  SOURCE="fuby"
  
  attr :rest_format, true	 
  
  # get recent message by id
  def self.get_messages_by_id(id,len)
    fanfou = FanfouAPI.new
    @fanfou_result = fanfou.show_user_messages(:id => id)
    @fanfou_xml = ''
    @fanfou_result.each {|l| @fanfou_xml += l}
    Hash.from_xml(@fanfou_xml)["statuses"]["status"][0..len]
  end
  
  class FanfouAPI 
    
    def initialize  rest_format='xml'
      @rest_format= verify_rest_format(rest_format) 
      @username=nil
      @password=nil
      @verify=false
    end  
    
    def login  name, pwd 
      @username=name
      @password=pwd
     # @verify
       
     	if verify
     		@verify=true
     	else
     		@verify=false
     	end
          
    end  
    
    #
    #This is  a private method
    #
    #
  def  verify
       processing_request("account/verify_credentials")[1]   
  end 
    
  def radom_browsing options={}  
      show_context("statuses/public_timeline",nil,options)       
  end  
   
  #
  #if there no :id  will need check the user's status 
  #
  #
  def show_friends_and_me_messages options={}  
        show_context("statuses/friends_timeline",{:no_id_need_login=>true},options)         
  end
    
  def show_user_messages options={}  
        show_context("statuses/user_timeline",{:no_id_need_login=>true},options)      
  end
    
  def show_message mess_id
        show_context("statuses/show/#{mess_id.to_s}")    
  end 
    
    
  def show_sendto_me_messages options={}  
      show_context("statuses/replies",{:need_login=>true},options)      
  end 
     
     
     
     
     
     
  def  show_context method,login_options={}, options={}  
     processing_request(method,login_options,options)[0] 
  end 
     
     
     
  def  processing_request method,login_options={}, options={}   
    login_options||={}
    options||={} 
    no_id_need_login=login_options.fetch(:no_id_need_login,false)  
    need_login=login_options.fetch(:need_login,false)  
    validate_parammeters(no_id_need_login,need_login,options)
      
    url = get_url(method,options) 
    #open_fanfou_uri  url.to_s   
    open_fanfou_uri_back  url.to_s
  end 
   
     
          
   def open_fanfou_uri_back url 
      body,code=[],false
      
       if name_password()  
			begin         
         open(url, "Authorization"=>"Basic #{name_password().to_s}"){|html|
           html.each_line{|line|body<<line}   
           code=true
         } 
         
        # rescue OpenURI::HTTPError=> o
         	 
         	#code=false
        end
       else
         open(url){|html|
          html.each_line{|line|body<<line} 
          code=true
         } 
       end  
       
      [body,code]
    end
    
    
    def open_fanfou_uri url  
    #need paramteres. I will fix this method
    	url = URI.parse(url)    
    	p url.class
    #	p url.class.instance_methods
    	p url.query
    	req = Net::HTTP::Get.new(url.path)
    	req.set_form_data({:count=>1})
    	p req
    	if name_password() 
    		req.basic_auth @username,@password
    	end 
    	res = Net::HTTP.new(url.host, url.port).start {|http|  http.request(req ) }  
    	is_ok=nil
      case res 
      when Net::HTTPSuccess, Net::HTTPRedirection
        is_ok=true
      else
        is_ok=false
      end
      
      [res.body,true]
      #res
    end
     
     
    
    def show_friends options={}   
       show_context("users/friends",{:no_id_need_login=>true},options)       
    end
    
     
     def show_followers options={}   
       show_context("users/followers",{:no_id_need_login=>true},options)       
    end
     
     

    
    def show_user_detail id=nil 
       show_context("users/show",{:no_id_need_login=>true},{:id=>id})     
    end 
     
         
    def private_received_messages options={}
        show_context("direct_messages",{:need_login=>true},options)       
    end 
     
     def private_send_messages options={}
        show_context("direct_messages/sent",{:need_login=>true},options)       
    end      
     

     
     
    def search query
      #  http://api.fanfou.com/search/public_timeline.[json|xml]   
      show_context("search/public_timeline",nil,{:q=>query})    
      #q 
    end 
     
     

    
    
    def post_message message,in_reply_to_status_id=nil 
      # status - require
      # in_reply_to_status_id   option
      #source option = SOURCE
      #http://api.fanfou.com/statuses/update.[json|xml] 
      # url=get_url("statuses/update",{}) 
      # do_post_data(url,{:status=>status,:in_reply_to_status_id=>in_reply_to_status_id})
      
       do_post_data "statuses/update",{:source=>SOURCE,:status=>message,:in_reply_to_status_id=>in_reply_to_status_id}
       #here is add message
      
    end
    
     def delete_message ms_id  
      #http://api.fanfou.com/statuses/destroy.[json|xml] 
      
   #   url=get_url("destroy/#{id.to_s}",nil)
      
     # do_post_data(url}
       
       do_post_data "statuses/destroy/#{ms_id.to_s}"
	  # here is deleted message  
	  # 没有这条消息     
      
      #id - require
      #show_resource("destroy/#{id.to_s}",false,false,{})    
    end   
     
     
     def upload_image photo,status=""
       # photo <input type="file" name="photo" /> require
       # status - describe photo
       # source - source 
       do_post_data "photos/upload",{:photo=>photo,:status=>status,:source=>SOURCE},true
     end 
     
     
     
     def send_private_message user, message , in_reply_to_id=nil
       #http://api.fanfou.com/direct_messages/new.[json|xml]  
      # POST
      
       #url=get_url("direct_messages/new",{}) 
       #do_post_data(url,{:user=>user,:text=>text,:in_reply_to_id =>in_reply_to_id })
        do_post_data "direct_messages/new",{:user=>user,:text=>message,:in_reply_to_id =>in_reply_to_id }
      
     end
     
     
     def delete_private_message private_id
       #http://api.fanfou.com/direct_messages/destroy.[json|xml] 
       #http://api.fanfou.com/direct_messages/destroy.xml?id=102  
       #url=get_url("direct_messages/destroy",{:id=>private_id})
      # do_post_data(url)
       
       
       do_post_data "direct_messages/destroy/#{private_id}"
       
       #I didn't know why here cann't delete the message
     end
     
     
     

    
    
    def add_friend friend_id
    #http://api.fanfou.com/friendships/create.[json|xml] 
# http://api.fanfou.com/friendships/create.xml?id=fanfou     
       #url=get_url("friendships/create",{:id=>fanfou}) 
       #do_post_data(url)
       
       
       do_post_data "friendships/create/#{friend_id}" 
    end
    
    def delete_friend friend_id
    #http://api.fanfou.com/friendships/destroy.[json|xml] 
    #http://api.fanfou.com/friendships/destroy/fanfou.xml 
     # url=get_url("friendships/destroy",{:id=>fanfou})
      #do_post_data(url)
      
       do_post_data "friendships/destroy/#{friend_id}" 
      
    end
  

  def add_to_blacklist black_id
    #http://api.fanfou.com/blocks/create.xml?id=fanfou
    #POST 
    #http://api.fanfou.com/blocks/create/fanfou.xml 
    
    #Eurl=get_url("blocks/create",{:id=>black_id})
    #do_post_data(url)
    
     do_post_data "blocks/create/#{black_id}" 
  end
    
  def delete_from_blacklist black_id
  #http://api.fanfou.com/blocks/destroy.[json|xml]  
  #http://api.fanfou.com/blocks/destroy.xml?id=fanfou 
   #url=get_url("blocks/destroy",{:id=>black_id})
  # do_post_data(url)
   
   do_post_data "blocks/destroy/#{black_id}"
    
  end
     
      
      
  def do_post_data method,data={} , is_multipart=false
  	#multipart/form-data
    
    url=get_url(method)
    
    data||={}
    url = URI.parse(url)
    req = Net::HTTP::Post.new(url.path)
    req.basic_auth @username,@password
    req.set_form_data( data)

	 if is_multipart
		req.set_content_type("multipart/form-data")
		req.body = %Q{--bbb\015   
			Content-Disposition: form-data; name="upload_file[]"; filename="my_file"  
			Content-Type: application/octet-stream\015\012\015   
			this is the content of the upload file.   
			this is the content of the upload file.   
			this is the content of the upload file.   
			--bbb\015   
			Content-Disposition: form-data; name="upload_file[]"; filename=""  
			Content-Type: application/octet-stream\015\012\015   
			--bbb--}
	 end
    
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    case res 
    when Net::HTTPSuccess, Net::HTTPRedirection
    	  puts  res.body
        puts  "消息执行成功"
        true                
    else
     	puts "执行失败"
     	false  
    end
    
    res    
      
      
  end

     
     
     
     
   def rest_format=(rest_format) 
       @rest_format= verify_rest_format(rest_format)  
   end 
     
    def verify_count count
        tm = 20
        tm=count.to_i if count.respond_to?:to_i 
        tm =20 if tm<0 || tm>20 
        tm 
    end
    
    
    def verify_rest_format format 
       format= "xml" unless AVAILABLE_FORMAT.index( format)  
       format
     end
       
       
      
     def params_to_s  options={}    
      
      url=nil
      if  options
        unless options.empty?
          if options.respond_to? :map
            url=options.map {|k,v| "#{(k.to_s)}=#{(v.to_s)}" }.join('&') if options 
            url=URI.escape(url) 
          end
        end
      end 
      if url
        url="?"+url        
      end  
      url 
     end 
       
     def  get_url method,options={}  
        url=FAN_FOU_HOST.dup 
        url<<method<<"."<<@rest_format<<params_to_s(options)
         p url.to_s
        url.to_s
     end 
       
      
      def validate_parammeters no_id_need_login=false,need_login=false,options={} 
         id= options.fetch(:id,nil)   
         if no_id_need_login
           raise  NoIDNeedLoginException("no id need login in")  unless id  
        end   
        if need_login 
           raise  NeedLoginInException("please login in")  unless name_password() 
        end 
        
        
      end  
       
    def name_password 
      if @username
        [@username+":"+@password].pack('m')  
      else
        nil
      end
      
    end
    
     
     
     
     private :get_url, :params_to_s, :verify_rest_format, :verify_count, :open_fanfou_uri,:verify
    
  end 
  
  class NeedLoginInException < RuntimeError 
    def initialize ms
      @message = ms
    end
    def to_s
       @message 
      
    end
    
  end
  
  class NoIDNeedLoginException < RuntimeError 
    
    def initialize ms
      @message = ms
    end
    def to_s
       @message  
    end
    
  end 

  class LoginFailException < RuntimeError 
     def initialize ms
      @message = ms
    end
    def to_s
       @message  
    end
       
    
  end 


end



if __FILE__==$0
  
  fanfou=Fanfou::FanfouAPI.new 
  
  fanfou.login("ronghai","weisead")
 # fanfou. radom_browsing()
   # puts  fanfou.show_friends_and_me_messages(:id=>"ronghai",:count=>2)
 #  puts fanfou. show_user_messages(:id=>"ronghai",:count=>2)
 
 #puts fanfou.show_sendto_me_messages(:id=>"fff")
 #   puts  fanfou.show_friends(:id=>"ronghai",:count=>1)
  #  puts  fanfou.show_followers(:id=>"ronghai",:page=>1) 
  #puts fanfou. show_user_detail("kidultnana")
  
  #puts fanfou.private_received_messages()
 # puts fanfou.private_send_messages()
  #puts fanfou.search("test")
   
    #fanfou.post_message("这是一个测试消息")
 #   fanfou. delete_message("UP5wwoM8MEw")
 #fanfou.send_private_message("若水","不好意思这是一个我的测试消息")
 #  fanfou.delete_private_message(1898518)  
 # fanfou.add_friend "aggie"
 #fanfou.delete_friend "aggie"
 #fanfou.add_to_blacklist "aggie"
 #fanfou.delete_from_blacklist "aggie"
  fanfou. upload_image "",true
  
end
