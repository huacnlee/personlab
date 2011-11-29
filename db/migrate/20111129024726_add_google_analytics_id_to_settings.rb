class AddGoogleAnalyticsIdToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :google_analytics_id, :string
    add_column :settings, :footer_html, :text
    add_column :settings, :feed_url, :string
  end

  def self.down
    remove_column :settings, :feed_url
    remove_column :settings, :footer_html
    remove_column :settings, :google_analytics_id
  end
end