class RemoveSettingBlogFeedHtml < ActiveRecord::Migration
  def self.up
    remove_column :settings, :blog_feed_html
  end

  def self.down
    add_column :settings, :blog_feed_html, :string
  end
end
