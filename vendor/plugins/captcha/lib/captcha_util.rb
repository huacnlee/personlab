require 'digest/sha1'

module CaptchaUtil

  def self.random_image
    @@captcha_files ||= Dir.glob("#{Rails.root}/public/system/captcha/*.gif").map {|f| File.basename(f)}
    
    if @@captcha_files.blank?
      Rails.logger.warn("Not generate captcha images in public/system/captcha.")
      return ""
    end
    @@captcha_files[rand(@@captcha_files.size)]
  end

  def self.encrypt_string(string)
    salt = 'This really should be random'

    if defined?(CAPTCHA_SALT)
      salt = CAPTCHA_SALT
    else
      Rails.logger.warn("No salt defined, please add CAPTHCA_SALT = 'Something really random' to environment.rb")
    end  

    Digest::SHA1.hexdigest("#{salt}#{string}")
  end

end