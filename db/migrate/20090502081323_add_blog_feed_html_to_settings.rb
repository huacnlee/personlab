class AddBlogFeedHtmlToSettings < ActiveRecord::Migration
  def self.up
    change_table :settings do |t|
      t.text :blog_feed_html
    end
  end

  def self.down
    change_table :settings do |t|
      t.remove :blog_feed_html
    end
  end
end
