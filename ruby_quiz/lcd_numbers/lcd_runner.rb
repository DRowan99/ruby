require 'optparse'
require_relative 'lcd_numbers.rb'

options = {}
opts = OptionParser.new do |create_opts|
	create_opts.banner = "Usage: lcd_runner.rb <print string> [options]"
	create_opts.separator "Available options:"

	create_opts.on("--size INTEGER","-s", Integer,
		"Specify the print size. Default is 2.") {|s| options[:size] = s}

	create_opts.on("--spacing INTEGER","-k", Integer,
		"Specify the spacing. Default is 1.") {|k| options[:spacing] = k}

	create_opts.separator ""

	create_opts.on_tail("--help","-h","List the availabe options",
		" and details about how they work") {puts opts; exit}
end

if ARGV.empty?; puts opts; exit; end
opts.parse! ARGV

printer = LCD::Printer.new
printer.print ARGV.first, options