module MadLib
	require 'yaml'

	MADLIB_DIR = File.expand_path(File.dirname(__FILE__))

	class Generator
		attr_reader :libs, :madlib, :replacements, :repeat_substitute

		def initialize
			@libs = YAML.load(File.read(MADLIB_DIR + '/madlibs.yml'))
		end

		def get(madlib = nil, list = [])
			@replacements = []
			@repeat_substitute = {}
			@madlib = MadLib::Parser.new madlib || @libs.shift

			@madlib.blanks.each do |blank|
				
				@replacements << if @madlib.repeats.include?(blank)
					@repeat_substitute[blank]
				elsif !list.empty?
					list.shift
				else
					print "Enter #{blank.split(":").last}: "
					$stdin.gets.strip
				end

				if blank.match(/:/)
					repeat = blank.split(":").first
					@repeat_substitute[repeat] = @replacements.last
				end
			end

			puts @madlib.sentence.zip(@replacements.map{|str| str.red}).flatten.join
		end
	end

	class Parser
		attr_reader :madlib, :sentence, :blanks, :repeats

		def initialize(madlib = nil)
			@sentence, @blanks, @repeats = [], [], []
			parse(madlib) if madlib
		end

		def parse(madlib = @madlib)
			@madlib = madlib

			@madlib.split(/\(\(|\)\)/).each_with_index do |part, i|
				if i.even?
					@sentence << part
				else
					@blanks << part
					@repeats << part.split(":").first if part.match(/:/)
				end
			end
		end
	end
end

class String
	# Small monkeypatch to change the color of the string to red in the 
	# console window to highlight the mad libs.
	def red
		"\e[31m#{self}\e[0m"
	end
end