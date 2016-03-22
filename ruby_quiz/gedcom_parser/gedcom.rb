module GEDCOM
	GEDCOM_DIR = File.expand_path(File.dirname(__FILE__))

	class Parser
		attr_reader :current_depth, :depth, :open_tags, :xml

		DEFAULT_FILE = '/bill_clinton_sample.ged'

		def initialize(gedcom_file = GEDCOM::GEDCOM_DIR+DEFAULT_FILE)
			@gedcom_file = File.open(gedcom_file)
			@nesting_depth, @current_depth = -1, 0
			@open_tags = []
		end

		def generate(options = {})
			@output = File.open(GEDCOM::GEDCOM_DIR+"/bill_clinton_sample_genealogy.xml","w")
			open_tag "gedcom"

			parse @gedcom_file.readline until @gedcom_file.eof?

			@current_depth = 0
			close_tags until @open_tags.empty?

			@output.close
			@output.path
		end

		def parse(line)
			ged = line.split(" ")
			@current_depth = ged.shift.to_i + 1

			close_tags while @nesting_depth > 0 && @current_depth <= @nesting_depth

			id = (ged.first.match(/^@\w+@$/i) ? ged.shift : nil)

			tag, *content = ged
			open_tag(tag.downcase, id: id, text: content.join(" "))
		end

		private

		def open_tag(tag, options = {})
			@output << "\n" unless @output.pos == 0
			@output << indent + "<#{tag}"
			@output << " id=\"#{options[:id]}\"" if options[:id]
			@output << ">#{options[:text]}"

			@open_tags << tag
			@nesting_depth += 1
		end

		def close_tags
			@output << "</#{@open_tags.pop}>"
			@output << "\n" + indent(@nesting_depth - 1) if @current_depth < @nesting_depth
			@nesting_depth -= 1
		end

		def indent(depth = nil)
			" " * 2 * (depth || @current_depth)
		end
	end
end