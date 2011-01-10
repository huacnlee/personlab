require 'xmlrpc/client'

rpc = XMLRPC::Client.new2("http://localhost:3000/xmlrpc")

begin
  puts rpc.call("wp.getUsersBlogs","admin","123123")
  
  puts rpc.call("wp.getTags","1","","123123")
rescue XMLRPC::FaultException => e
  puts "* [Error #{e.faultCode}]: #{e.faultString}"
end

