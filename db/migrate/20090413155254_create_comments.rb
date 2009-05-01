class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :post, :null => false
      t.string :author,:null => false
      t.string :email,:null => false
      t.string :url
      t.string :body,:null => false
      t.integer :status,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
