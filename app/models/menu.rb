class Menu < ActiveRecord::Base
  validates_presence_of :name,:url, :message => "不能为空"
  validates_uniqueness_of :name,:case_sensitive => false, :message => "已经有同名的存在."
  
  def self.find_all
    find(:all,:order => "sort desc")
  end
end
