module GEDCOM
	GEDCOM_DIR = File.expand_path(File.dirname(__FILE__))

	class Parser
		attr_reader :current_depth, :depth, :open_tags, :xml

		DEFAULT_FILE = '/us_presidents.ged'

		def initialize(gedcom_file = GEDCOM::GEDCOM_DIR+DEFAULT_FILE)
			@xml = ""
			@gedcom_file = File.open(gedcom_file)
			@open_tags, @depth = [], []
		end

		def parse!()
			loop do 
				ged_parse @gedcom_file.readline
			end until @gedcom_file.eof?
		end

		def ged_parse(ged_line)
			ged = ged_line.split(" ")
			@current_depth = ged.shift.to_i

			while @depth.last && @current_depth <= @depth.last
				xml_close_open_tags
			end

			id = (@current_depth == 0 ? ged.shift : nil)

			tag, *content = ged
			xml_open(tag, id: id, text: content.join(" "))

			@xml
		end

		private

		def xml_open(tag, options = {})
			@xml << "<#{tag}"
			@xml << " id=\"#{options[:id]}\"" if options[:id]
			@xml << ">#{options[:text]}"
			@open_tags << tag
			@depth << @current_depth
		end

		def xml_close_open_tags
			unless @current_depth == @depth.pop
				@xml << "\n"
				@xml << @current_depth * 2 * " " 
			end
			@xml << "</#{@open_tags.pop}>"
		end
	end
end