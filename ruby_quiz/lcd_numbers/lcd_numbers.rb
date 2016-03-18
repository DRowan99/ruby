module LCD
	require 'yaml'
	LCD_DIR = File.expand_path(File.dirname(__FILE__))
	CHAR_BLUEPRINTS = YAML.load(File.read(LCD_DIR + '/char_blueprints.yml'))

	class Printer
		attr_reader :top, :upper, :middle, :lower, :bottom
		attr_accessor :size, :spacing

		def initialize(size = 2, spacing = 1)
			@size, @spacing = size, spacing
			@top, @upper, @middle, @lower, @bottom = [], [], [], [], []
		end

		def print(*chars)
			chars.each {|char| send "__#{char}__"}
			print_screen
		end

		((0..9).to_a + ["A", "B", "C", "D", "E", "F"]).each do |char|
			instructions = CHAR_BLUEPRINTS[char]
			define_method("__#{char}__") do 
				top instructions["top"]
				upper instructions["upper"]
				middle instructions["middle"]
				lower instructions["lower"]
				bottom instructions["bottom"]
				return nil
			end
		end
	
		def print_screen(size_n = nil, spacing_m = nil)
			return if @top.empty?
			size = (size_n || @size)
			spacing = (spacing_m || @spacing)

			[@top, @upper, @middle, @lower, @bottom].each_with_index do |line, i|
				(i.even? ? 1 : size).times do
					puts line.map{|chars| chars.call(size)}.join(" " * spacing)
				end
			end
			return nil
		end

		private

		[:top, :upper, :middle, :lower, :bottom].each do |name|
			define_method(name) do |arg|
				line = instance_variable_get "@#{name}"
				(line||= []) << send(arg)
				instance_variable_set "@#{name}", line
			end

			LCD::Printer.instance_eval { private name.to_sym}
		end

		def blank
			Proc.new { |n| " " * (n + 2) }
		end
	
		def line
			Proc.new { |n| " " + ("-" * n) + " " }
		end
	
		def left_vert
			Proc.new { |n| "|" + " " * (n + 1) }
		end
	
		def right_vert
			Proc.new { |n| " " * (n + 1) + "|" }
		end
	
		def both_vert
			Proc.new { |n| "|" + " " * n + "|" }
		end
	end
end