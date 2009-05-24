class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts


  # override save for name unique
  def save
    old = self.class::find_by_name(self.name)
    if old
      logger.debug { "existed!" }
      self.id = old.id
      self.created_at = old.created_at
      self.updated_at = old.updated_at
      return true
    else
      super
    end
  end
end
