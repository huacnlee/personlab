class CreateUnfollowers < ActiveRecord::Migration
  def self.up
    create_table :unfollowers do |t|
      t.references :unfollowerable, :polymorphic => true
      t.string :email, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :unfollowers
  end
end
