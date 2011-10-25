class RemoveComments < ActiveRecord::Migration
  def self.up
    drop_table :comments
    remove_column :posts, :comment_count
  end

  def self.down
    create_table :comments
    add_column :posts, :comment_count, :integer, :default => 0, :null => false
  end 
end
