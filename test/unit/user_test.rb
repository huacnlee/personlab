require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :users
  
  def test_create
    user = User.new
    assert(!user.save)
    user = User.new(:uname => 'user1')
    assert(!user.save)
    user = User.new(:uname => 'user1',:pwd => '123123')
    assert(!user.save)
    user = User.new(:uname => 'user1',:pwd => '123123',:name => 'User one')
    assert(user.save,user.errors.full_messages.join("; "))
  end
  
  def test_encode
    assert_equal("dbb9676ba9f339da83c512f801703945", User.encode("123123"))
  end
  
  def test_check_login
    user = User.check_login("jasonlee",User.encode("123123"))
    assert(user != nil)
  end
end
