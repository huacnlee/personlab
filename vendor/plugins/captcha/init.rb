$:.unshift "#{File.dirname(__FILE__)}/lib"

require 'captcha_util'
require 'captcha_helper'
require 'validates_captcha'

ActionController::Base.class_eval do
  include ValidatesCaptcha
end
