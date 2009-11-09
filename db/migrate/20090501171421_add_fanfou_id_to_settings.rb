class AddFanfouIdToSettings < ActiveRecord::Migration
  def self.up
    change_table :settings do |t|
      t.string :fanfou_id
    end
  end

  def self.down
    change_table :settings do |t|
      t.remove :fanfou_id
    end
  end
end
