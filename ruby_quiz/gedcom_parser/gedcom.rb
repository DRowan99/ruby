module GEDCOM
	GEDCOM_DIR = File.expand_path(File.dirname(__FILE__))

	class Parser
		attr_reader :current_depth, :depth, :open_tags, :xml

		DEFAULT_FILE = '/bill_clinton_sample.ged'

		def initialize(gedcom_file = GEDCOM::GEDCOM_DIR+DEFAULT_FILE)
			@gedcom_file = File.open(gedcom_file)
			@current_depth = 0
			@open_tags, @depth = [], []
		end

		def parse!()
			@xml = File.open("bill_clinton_sample_genealogy.xml","w")
			open_tag "gedcom"

			parse @gedcom_file.readline until @gedcom_file.eof?

			@current_depth = 0
			close_tags until @open_tags.empty?

			@xml.close
			nil
		end

		def parse(line)
			ged = line.split(" ")
			@current_depth = ged.shift.to_i + 1

			close_tags while @depth.last && @current_depth <= @depth.last

			id = (ged.first.match(/^@\w+@$/i) ? ged.shift : nil)

			tag, *content = ged
			open_tag(tag.downcase, id: id, text: content.join(" "))
		end

		private

		def open_tag(tag, options = {})
			@xml << "\n" unless @xml.pos == 0
			@xml << indent + "<#{tag}"
			@xml << " id=\"#{options[:id]}\"" if options[:id]
			@xml << ">#{options[:text]}"
			@open_tags << tag
			@depth << @current_depth
		end

		def close_tags
			prev_depth = @depth.pop

			@xml << "</#{@open_tags.pop}>"
			@xml << "\n" + indent(@depth.last) if @current_depth < prev_depth
		end

		def indent(depth = nil)
			" " * 2 * (depth || @current_depth)
		end
	end
end