class CreateTableUser < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string :uname,:null => false
      t.string :pwd,:null => false
      t.string :name,:null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
