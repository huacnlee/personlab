class RemoveTagTable < ActiveRecord::Migration
	def self.up
		drop_table :tags
		drop_table :posts_tags
  end

  def self.down
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

		create_table :posts_tags, :force => true do |t|
      t.references :post, :null => false
      t.references :tag, :null => false
      t.timestamps
    end
  end
end
