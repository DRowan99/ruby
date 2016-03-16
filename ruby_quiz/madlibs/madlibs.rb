module MadLib
	require 'yaml'

	MADLIB_DIR = File.expand_path(File.dirname(__FILE__))

	class Generator
		attr_reader :libs, :madlibs_file, :parser, :madlib, :replacements, :repeat_substitute

		def initialize(file_name = nil)
			@madlibs_file = (file_name || MADLIB_DIR + '/madlibs.yml')
			load_libs_from(@madlibs_file)
		end

		def get(madlib = nil)
			@replacements = []
			@repeat_substitute = {}
			@parser = MadLib::Parser.new madlib || @libs.shift

			@parser.blanks.each do |blank|
				prompt, blank_alias = blank.split(":").reverse

				@replacements << if @parser.repeats.include?(prompt)
					@repeat_substitute[prompt]
				else
					print "Enter #{prompt}: "
					$stdin.gets.strip
				end

				@repeat_substitute[blank_alias] = @replacements.last if blank_alias
			end

			puts "", @parser.sentence.zip(@replacements.map{|str| str.red}).flatten.join, ""
		end

		def from_file(file_name)
			@madlibs_file = file_name
			load_libs_from @madlibs_file
			
			self
		end

		def madlib
			@parser.madlib
		end

		private

		def load_libs_from(file_name)
			@libs = YAML.load(File.read(file_name)).shuffle
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
	# Small monkeypatch to change the color of a string to red in the console window
	def red
		"\e[31m#{self}\e[0m"
	end
end