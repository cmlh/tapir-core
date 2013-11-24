task_dir = File.join(File.expand_path(File.dirname(__FILE__)), "tasks")
Dir[task_dir + "/" + "*.rb"].each do |file|
  require file
end
