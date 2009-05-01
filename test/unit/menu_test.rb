require File.dirname(__FILE__) + '/../test_helper'

class MenuTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :menus
  
  def test_create_complete
    # test name blank
    @menu = Menu.new
    assert(!@menu.save)
    
    # url blank
    @menu = Menu.new(:name => "Menu one")
    assert(!@menu.save)
    
    # 不传sort和new_window也能保存
    @menu = Menu.new(:name => "Menu one",:url => "/menu1")
    assert(@menu.save,@menu.errors.full_messages.join("; "))
    
    # 只是不传 new_window 也能保存
    @menu = Menu.new(:name => "Menu two",:url => "/menu2",:sort => 3)
    assert(@menu.save,@menu.errors.full_messages.join("; "))
    
    # 所有参数都传也能保存
    @menu = Menu.new(:name => "Menu three",:url => "/menu3",:sort => 3,:new_window => false)
    assert(@menu.save,@menu.errors.full_messages.join("; "))
  end
  
  def test_unique_name
    # Project 已在 fixtures 里面有了的
    @menu = Menu.new(:name => "Project",:url => "/project")
    assert(!@menu.save)
    
    # 测试 小写
    @menu = Menu.new(:name => "project",:url => "/project")
    assert(!@menu.save)
  end
end
