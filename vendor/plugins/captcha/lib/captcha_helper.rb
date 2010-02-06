module CaptchaHelper
    
   def captcha_image(options = {})
      @captcha_image ||= CaptchaUtil::random_image
      image_tag('/system/captcha/' + @captcha_image, options)
   end
   
   def captcha_input_text(label, options = {})
      @captcha_image ||= CaptchaUtil::random_image
      content_tag('label', label, :for => 'captcha') + text_field_tag(:captcha, nil, options)
   end
   
   def captcha_hidden_text
      @captcha_image ||= CaptchaUtil::random_image
      hidden_field_tag(:captcha_validation, @captcha_image.gsub(/\..+$/,''))
   end
   
   def captcha_block(label = 'Please type the characters in the image below')
      content_tag('div', captcha_hidden_text + captcha_input_text(label) + captcha_image, { :class => 'captcha' })
   end
   
end

