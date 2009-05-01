class PostFellow < ActiveRecord::Migration
  def self.up
    create_table :post_fellow, :force => true do |t|
      t.string :email, :null => false
      t.references :post, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :post_fellow
  end
end
