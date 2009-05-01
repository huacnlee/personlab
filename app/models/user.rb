class User < ActiveRecord::Base
  validates_presence_of :uname, :pwd, :name,:message => "不能为空."
  
  def self.encode(pwd)
    Digest::MD5.hexdigest("--@*&^!*987-!^!*--#{pwd}")
  end
  
  def self.check_login(uname,pwd)
    find(:first, :conditions => ['uname = ? and pwd = ?', uname, pwd])
  end
end
