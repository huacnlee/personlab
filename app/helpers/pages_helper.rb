require "RedCloth"
module PagesHelper
  def textile(body)
    RedCloth.new(body).to_html
  end
end
