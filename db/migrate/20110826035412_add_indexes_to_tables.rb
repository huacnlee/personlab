class AddIndexesToTables < ActiveRecord::Migration
  def self.up
    add_index :posts, :slug, :uniq => true
    add_index :posts, :category_id
    add_index :posts, :status
    add_index :categories, :slug, :uniq => true
    add_index :comments, :post_id
    add_index :pages, :slug, :uniq => true
    add_index :unfollowers, [:unfollowerable_id, :unfollowerable_type]
  end

  def self.down
    remove_index :unfollowers, [:unfollowerable_id, :unfollowerable_type]
    remove_index :posts, :status
    remove_index :posts, :category_id
    remove_index :pages, :slug
    remove_index :comments, :post_id
    remove_index :categories, :slug
    remove_index :posts, :slug
  end
end
