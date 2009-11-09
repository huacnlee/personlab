class Comment < ActiveRecord::Base
  belongs_to :post

  validates_presence_of :author,:email,:body, :message => "还未填写."
	default_scope :order => 'id ASC'
  has_rakismet :author => :author,
              :author_url => :url,
              :author_email => :email,
              :content  => :body,
              :user_ip => :user_ip,
              :user_agent => :user_agent,
              :referrer  => :referrer
              
	before_create :before_create
	
  def created_at_s
    created_at.to_s(:short_time_string)
  end
  
  def self.find_list(page = 1, per_page = 20,options = {})
    with_scope :find => options do
      paginate(:page => page, :per_page => per_page, :conditions => ['status = ?', 1])
    end
  end
  
  def self.find_recent(size = 10, options = {})
    with_scope :find => options do
      paginate :page => 1, :per_page => size, :conditions => ['status = ?', 1], :order => "id desc"
    end
  end
  
  # 删除所有 spams
  def self.delete_spams
    destroy_all(:status => 2)
  end
  
  def before_create
    if self.spam?
      self.status = 2
    else
      self.status = 1
    end
  end
  
  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end
  
  def mark_as_spam!
    update_attribute(:status, 2)
  end
  
  def mark_as_ham!
    update_attribute(:status, 1)
  end
end

