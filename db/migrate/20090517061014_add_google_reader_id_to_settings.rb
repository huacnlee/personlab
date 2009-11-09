class AddGoogleReaderIdToSettings < ActiveRecord::Migration
  def self.up
    change_table :settings do |t|
      t.string :google_reader_id  
    end
  end

  def self.down
    change_table :settings do |t|
      t.remove :google_reader_id
    end
  end
end
