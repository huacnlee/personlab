class AddViewCountToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.integer :view_count, :null => false, :default => 0
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :view_count
    end
  end
end
