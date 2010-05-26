require "base64"

# custom encoder
class Encoder
  ENCODER_PREFIX = "personlab-%^@*!"
  
  # encode string
  def self.encode(str)
    Base64.encode64(str + ENCODER_PREFIX)
  end

  # decode string
  # when code unvalidate return nil
  def self.decode(code)
    str = Base64.decode64(code)
    return nil if not str.index(ENCODER_PREFIX)
    str[0..str.length-ENCODER_PREFIX.length-1]
  end
end