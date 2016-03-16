require 'optparse'
require_relative 'madlibs.rb'

options = {}
opts = OptionParser.new do |create_opts|
	create_opts.banner = "Usage: madlib_runner.rb [options]"
	create_opts.separator "Available options:"

	create_opts.on("--madlibs-file FILE", "-f", String, 
		"Specify a YAML file to load madlibs from.",
		" The YAML file should produce an array",
		" of madlibs in the expected format.") { |file_name| options[:madlibs_file] = file_name }

	create_opts.separator ""

	create_opts.on_tail("--help", "-h", "List the availabe options",
		" and details about how they work") {puts opts; exit}
end

opts.parse! ARGV

madlib_generator = MadLib::Generator.new(options[:madlibs_file])

while madlib_generator.get do
	puts "", madlib_generator.madlib, ""
end