class AddCommentCountToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.integer :comment_count, :null => false, :default => 0
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :comment_count
    end
  end
end
