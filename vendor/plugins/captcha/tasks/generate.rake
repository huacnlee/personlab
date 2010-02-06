$:.unshift "#{File.dirname(__FILE__)}/../lib"

require 'captcha_image_generator'

namespace :captcha do

   desc 'Generate a set of captcha images off-line'
   task :generate => :environment do 
      FileUtils.mkdir_p('public/system/captcha')
      Dir.chdir('public/system/captcha') do
         image_count  = (ENV['COUNT'] || 3).to_i
         image_params = resolve_params
         puts "Generating #{image_count} captcha images off-line #{'with params '+image_params.inspect unless image_params.empty?}"
         for i in 1..image_count 
            CaptchaImageGenerator::generate_captcha_image(image_params)
         end
      end
   end
   
   def resolve_params
     params = {}
     ['IMAGE_WIDTH', 'IMAGE_HEIGHT', 'CAPTCHA_LENGTH', 'FILE_FORMAT'].each do |param|
       params[param.downcase.to_sym] = ENV[param] if ENV[param]
     end
     params 
   end 
end