puts "Adding CAPTCHA_SALT global variable to environment.rb"
environment = File.open("#{Rails.root}/config/environment.rb", 'a')
environment.puts("CAPTCHA_SALT = '#{CaptchaUtil.encrypt_string(rand(1000000000))}'")
environment.close
