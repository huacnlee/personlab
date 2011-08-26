begin
  require 'RMagick' 
rescue Exception => e
  puts "Warning: RMagick not installed, you cannot generate captcha images on this machine"
end

require 'captcha_util'

module CaptchaImageGenerator

  @@eligible_chars     = (2..9).to_a + %w(A B C D E F G H J K L M N P Q R S T U V X Y Z)
  @@default_colors     = ['#D02F01','#36AA09','#25689C','#383E51','#8D5D39']
  @@default_bg_colors  = ['#FFFFFF']
  @@default_fonts      = ['Arial','Verdana,Tahoma','MS Serif','Lucida Sans','Georgia']
  @@default_parameters = {
    :image_width    => 100,
    :image_height   => 30,
    :captcha_length => 4
  }

  def self.generate_captcha_image(params = {})

    params.reverse_merge!(@@default_parameters)

    file_format = '.gif'
    
    bg_color = @@default_bg_colors[rand(@@default_bg_colors.size)]
    fore_color = @@default_colors[rand(@@default_colors.size)]
    font = @@default_fonts[rand(@@default_fonts.size)]
    
    
    black_img = Magick::Image.new(params[:image_width].to_i, params[:image_height].to_i) do
      self.background_color = bg_color
      self.quality = 80
    end

    # Generate a 5 character random string
    random_string = (1..params[:captcha_length].to_i).collect { @@eligible_chars[rand(@@eligible_chars.size)] }.join('')
    

    # Gerenate the filename based on the string where we have removed the spaces
    filename = CaptchaUtil::encrypt_string(random_string.gsub(' ', '').downcase) + file_format

    # Render the text in the image
    black_img.annotate(Magick::Draw.new, 0,0,0,0, random_string) {
      self.gravity = Magick::CenterGravity
      self.font_family = font
      self.text_antialias = true      
      # self.font_weight = Magick::BoldWeight      
      self.fill = fore_color
      self.stroke = fore_color
      self.stroke_width = 0.3
      self.kerning = -3.5
      self.pointsize = 16
    }

    # Apply a little blur and fuzzing
    # black_img = black_img.gaussian_blur(1, 0.8)
    # black_img.dissolve(black_img.sketch(0, 2, 2), 0.75, 0.25)
    # black_img = black_img.spread(0.10)
    wave_ranges = (-8..8).collect.to_a
    wave_direct = wave_ranges[rand(wave_ranges.count)]
    black_img = black_img.wave(wave_direct, 120)
    black_img = black_img.resize_to_fill(params[:image_width],params[:image_height])
    # Write the file to disk
    puts 'Writing image file ' + filename
    
    black_img.write(filename)

    # Collect rmagick
    GC.start
  end

end  
