class AddDefaultData < ActiveRecord::Migration
  def self.up
    menu1 = Menu.new(:name => "Blog", :url => "/blog",:sort => 10)
    menu2 = Menu.new(:name => "About", :url => "/about",:sort => -99)
    menu3 = Menu.new(:name => "Work", :url => "/work",:sort => 9)
    menu4 = Menu.new(:name => "Share", :url => "/share",:sort => 8)
    menu1.save(false)
    menu2.save(false)
    menu3.save(false)
    menu4.save(false)
    
    page1 = Page.new(:title => "Work", :slug => "work", :body => "This is my work page.", :status => 1)
    page2 = Page.new(:title => "About", :slug => "about", :body => "About me.", :status => 1)
    page1.save(false)
    page2.save(false)
    
    cate = Category.first
    if not cate
      cate = Category.new(:name => "default", :slug => "default")
      cate.save(false)
    end
    
    post1 = Post.new(:title => "Hello world.", :slug => "hello-world", :body => "My first weblog.", :status => 1, :category_id => cate.id)
    post1.save(false)
  end

  def self.down
    page1 = Page.find_by_slug("work")
    page1.destroy if page1
    page2 = Page.find_by_slug("about")
    page2.destroy if page2
    post = Post.find_by_slug("hello-world")
    post.destroy if post
    Menu.delete_all
  end
end

