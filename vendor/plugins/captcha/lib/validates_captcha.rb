module ValidatesCaptcha
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def validates_captcha
      helper CaptchaHelper
      include ValidatesCaptcha::InstanceMethods
    end
  end
  
  module InstanceMethods
    def captcha_validated?
      return true if session[:captcha_skip] == true
 
      validated = CaptchaUtil::encrypt_string(params[:captcha].to_s.gsub(' ', '').downcase) == params[:captcha_validation]
      # if validated, save mark in the session, so the Captcha well not show
      if validated
        session[:captcha_skip] = true
      end
    end    
  end  
end  
