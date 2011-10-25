class AddDisqusShortnameToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :disqus_shortname, :string
  end

  def self.down
    remove_column :settings, :disqus_shortname
  end
end