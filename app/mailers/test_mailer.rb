# coding: utf-8 
class TestMailer < ActionMailer::Base
  helper :application
  def try(to,subject)
    subject "#{subject}"
    recipients to
    sent_on Time.now
    body subject
  end
  
  def self.try(to,subject)
    TestMailer.deliver_try(to,subject)
  end

end
