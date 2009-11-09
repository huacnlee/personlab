# sudo apt-get install ruby rubygems irb rake ruby-dev
sudo apt-get install ruby rubygems irb ri rdoc ruby1.8-dev build-essential libmysql-ruby libopenssl-ruby
sudo gem source -a http://gemcutter.org/ 
sudo gem source -a http://gems.github.com
sudo gem install -v=2.3.4 rails macaddr RedCloth simple-rss twitter4r --no-rdoc
rake db:create RAILS_ENV=production
rake db:migrate RAILS_ENV=production

# Install Nginx + Passenger
sudo gem install passenger

