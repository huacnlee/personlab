class CreatePostsTags < ActiveRecord::Migration
  def self.up
    create_table :posts_tags, :force => true do |t|
      t.references :post, :null => false
      t.references :tag, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :posts_tags
  end
end
