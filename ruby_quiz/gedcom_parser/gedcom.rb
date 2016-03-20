module GEDCOM
	require 'builder'

	GEDCOM_DIR = File.expand_path(File.dirname(__FILE__))

	class Parser
		attr_reader :current_depth, :current_line, :xml

		DEFAULT_FILE = '/us_presidents.ged'

		def initialize(gedcom_file = GEDCOM::GEDCOM_DIR+DEFAULT_FILE)
			@xml = Builder::XmlMarkup.new(:indent => 2)
			@gedcom_file = File.open(gedcom_file)
		end

		def parse!()
			line = @gedcom_file.readline
		end

		def parse_line(ged_str)
			ged = ged_str.split(" ")
			@current_depth = ged.shift

			case @current_depth
			when "0"
				@id, @current_tag, @content = ged
			else
				@current_tag, *@content = ged
			end
			@xml.__send__(@current_tag, @content ? @content.join(" ") : {id: @id})
		end
	end
end