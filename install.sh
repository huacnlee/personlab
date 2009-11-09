# sudo apt-get install ruby rubygems irb rake ruby-dev
gem sources -a http://gems.github.com
gem install -v=2.3.4 rails mysql macaddr RedCloth simple-rss twitter4r --no-rdoc
rake db:create RAILS_ENV=production
rake db:migrate RAILS_ENV=production
