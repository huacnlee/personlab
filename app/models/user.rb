class User < ActiveRecord::Base
  validates_presence_of :uname, :pwd, :name,:message => "不能为空."
  
  def self.encode(pwd)
    Digest::MD5.hexdigest("--@*&^!*987-!^!*--#{pwd}")
  end
  
  def self.check_login(uname,pwd)
    find(:first, :conditions => ['uname = ? and pwd = ?', uname, pwd])
  end

  # 更新密码
  def update_pwd(old_pwd,new_pwd,confirm_pwd)
    if old_pwd.blank?
      self.errors.add("旧密码","还未填写。")
      return false
    end

    if new_pwd.blank?
      self.errors.add("新密码","还未填写。")
      return false
    end

    if User.encode(old_pwd) != self.pwd
      self.errors.add("旧密码","不正确。")
      return false
    end

    if new_pwd != confirm_pwd
      self.errors.add("新密码与确认密码","不一至。")
      return false
    end

    self.pwd = User.encode(new_pwd)
    if self.save
      return true
    end
  end
end
