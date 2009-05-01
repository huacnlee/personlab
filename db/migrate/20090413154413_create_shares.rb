class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares do |t|
      t.string :title,:null => false
      t.string :summary,:null => false
      t.string :from
      t.string :cover
      t.string :url,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :shares
  end
end
