# spec_helper
puts "Everything in ../lib:"
Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "**/*.rb"))).each do |file|
  puts "    #{file}"
end
