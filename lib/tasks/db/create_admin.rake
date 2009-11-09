namespace :db do
  desc "Create admi user"
  task :create_admin => :environment do 
    require 'app/models/user'
		User.create(:uname => 'admin', :pwd => User.encode('123123'), :name => 'admin')
    puts "Admin created, login: admin ,password: 123123"
  end
end

