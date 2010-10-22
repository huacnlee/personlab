# coding: utf-8 
require "digest/md5"
require "encoder"
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # return the formatted flash[:notice] html
  def success_messages
    msg = ''
    if flash[:notice]
      msg = '
      <div id="successMessage" class="successMessage">
    		'+flash[:notice]+'
    	</div>
      '
    end
    raw msg
  end

  # form auth token
  def auth_token
    raw "<input name=\"authenticity_token\" type=\"hidden\" value=\"#{form_authenticity_token}\" />"
  end
  
  # return the Gravatar face by Email
  def face_url(email)
    hash = Digest::MD5.hexdigest(email)
    raw "http://www.gravatar.com/avatar/#{hash}?s=64"
  end

  # close html tag when truncated
  def close_tags(text)
    open_tags = []
    text.scan(/\<([^\>\s\/]+)[^\>\/]*?\>/).each { |t| open_tags.unshift(t) }
    text.scan(/\<\/([^\>\s\/]+)[^\>]*?\>/).each { |t| open_tags.slice!(open_tags.index(t)) }
    open_tags.each {|t| text += "</#{t}>" }
    return raw text
  end

  def truncate_html(html, options={})
    # Does not behave identical to current Rails truncate method i.e. you must pass options as a hash not just values
    # Sample usage: <%= html_truncate(category.description, :length => 120, :omission => "(continued...)" ) -%>...
    previous_tag = ""
    text, result = [], []
    
    # get all text (including punctuation) and tags and stick them in a hash
    html.scan(/<\/?[^>]*>|[A-Za-z.,;!"'?]+/).each { |t| text << t }
    
    text.each do |str|
      if options[:length] > 0
        if str =~ /<\/?[^>]*>/
          previous_tag = str
          result << str
        else
          result << str
          options[:length] -= str.length
        end
      else
        # now stick the next tag with a </> that matches the previous open tag on the end of the result 
        if str =~ /<\/([#{previous_tag}]*)>/
          result << str
        else
        end
      end
    end
    return raw(result.join(" ") + options[:omission].to_s)
  end
  
  # 退定连接
  def unfollow_link(email,unfollowerable)
    unfollow_url(:type => unfollowerable.class.class_name.downcase,
                  :id => unfollowerable.id,:key => Encoder.encode(email))
  end

end
