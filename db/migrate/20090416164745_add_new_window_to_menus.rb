class AddNewWindowToMenus < ActiveRecord::Migration
  def self.up
    change_table :menus do |t|
      t.boolean :new_window, :null => false, :default => false
    end
  end

  def self.down
    change_table :menus do |t|
      t.remove :new_window
    end
  end
end
