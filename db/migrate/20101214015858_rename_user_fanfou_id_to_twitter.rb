class RenameUserFanfouIdToTwitter < ActiveRecord::Migration
  def self.up
    rename_column :settings, :fanfou_id, :twitter_id
  end

  def self.down
    rename_column :settings, :twitter_id, :fanfou_id
  end
end
