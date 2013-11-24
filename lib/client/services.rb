#
# Individual service client files
#
service_client_dir = File.join(File.expand_path(File.dirname(__FILE__)), "services")
Dir[service_client_dir + "/" + "*.rb"].each do |file|
  require file
end
