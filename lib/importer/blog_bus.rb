module BlogBus
  IMPORT_PATH = "#{RAILS_ROOT}/db/import/"
  
  def self.read_backup(file_name)
    xml = File.read(IMPORT_PATH + file_name)
    doc,posts = REXML::Document.new(xml),[]
    doc.elements.each('BlogBusCom/Log') do |log|
      posts << log
    end
    
    posts
  end
end