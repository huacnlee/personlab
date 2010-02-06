class AddAdmin < ActiveRecord::Migration
  def self.up
    user = User.new(:uname => "admin", :pwd => User.encode("123123"), :name => "Admin")
    user.save(false)
  end

  def self.down
    User.find_by_uname("admin").destroy
  end
end

