require 'rexml/parsers/pullparser'
require 'guid'

class String
  def truncate_html(len = 30, ellipsis = "...")
    p = REXML::Parsers::PullParser.new(self)
    tags = []
    new_len = len
    results = ''
    while p.has_next? && new_len > 0
      p_e = p.pull
      case p_e.event_type
      when :start_element
        tags.push p_e[0]
        results << "<#{tags.last} #{attrs_to_s(p_e[1])}>"
      when :end_element
        results << "</#{tags.pop}>"
      when :text
        results << p_e[0].first(new_len)
        new_len -= p_e[0].length
      else
        results << "<!-- #{p_e.inspect} -->"
      end
    end
    tags.reverse.each do |tag|
      results << "</#{tag}>"
    end
    (results + ellipsis)
  end
  
  def remove_html_tag()
    self.gsub(/<.+?>/, "")
  end
  
  def html_decode
    es = {'&amp;' => '&', '&gt;' => '>', '&lt;' => '<', '&quot;' => '"'}
    self.gsub(/&amp;|&gt;|&lt;|&quot;/) { |s| es[s] }
  end
  
  # clear unsafe char with url slug
  def safe_slug(spliter = '-')
    @slug = self
    if @slug.blank?
      Guid.new
      @slug = Guid.generate      
    end
    @slug.gsub(/[^a-zA-Z\-0-9]/,spliter).downcase  
  end

  private
  def attrs_to_s(attrs)
    if attrs.empty?
      ''
    else
      attrs.to_a.map { |attr| %{#{attr[0]}="#{attr[1]}"} }.join(' ')
    end
  end
end