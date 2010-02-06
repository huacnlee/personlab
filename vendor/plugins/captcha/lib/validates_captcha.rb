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
       CaptchaUtil::encrypt_string(params[:captcha].to_s.gsub(' ', '').downcase) == params[:captcha_validation]
    end    
  end  
end  