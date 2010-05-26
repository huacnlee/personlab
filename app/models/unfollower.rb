class Unfollower < ActiveRecord::Base
  belongs_to :unfollowerable, :polymorphic => true
  
  validates_presence_of :email, :unfollowerable_type, :unfollowerable_id
  validates_uniqueness_of :email, :scope => [:unfollowerable_type,:unfollowerable_id]
  
  # 检查是否存在
  def self.exist(email,item)
    !find_by_email_and_unfollowerable_type_and_unfollowerable_id(email,item.class.class_name,item.id).blank?
  end
end
