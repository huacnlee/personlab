class AddCategoryToPosts < ActiveRecord::Migration
	def self.up
		change_table :posts do |t|
      t.references :category      
    end		
  end

  def self.down
   	change_table :posts do |t|
      t.remove :category_id
    end
  end
end
