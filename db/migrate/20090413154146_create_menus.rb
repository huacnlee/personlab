class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.string :name,:null => false
      t.string :url,:null => false
      t.integer :sort,:null => false,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
