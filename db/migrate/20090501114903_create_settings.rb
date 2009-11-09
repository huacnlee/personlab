class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :site_name
      t.string :sub_title
      t.string :email
      t.string :meta_keywords
      t.string :meta_description
      t.text :home_show

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
