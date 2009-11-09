class RemoveShares < ActiveRecord::Migration
  def self.up
    drop_table :shares
  end

  def self.down
    create_table "shares", :force => true do |t|
      t.string   "title",      :null => false
      t.string   "summary",    :null => false
      t.string   "from"
      t.string   "cover"
      t.string   "url",        :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
