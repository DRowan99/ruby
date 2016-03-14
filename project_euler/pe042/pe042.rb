# Expand to take list of words from the command line.
# Write README with details of how command line options work.

class Fixnum
	def triangular
		(self * (self + 1))/2
	end

	def triangular?
		n = 1
		loop do
			break if n.triangular >= self
			n += 1
		end
		return n.triangular == self
	end
end

CHAR_VALUE = ("A".."Z").each_with_index.inject({}) {|result,(letter,i)| result[letter] = i+1; result}
PE42_DIR = File.expand_path(File.dirname(__FILE__))
WORDS = File.read(PE42_DIR + '/words.txt').gsub(/[^,a-zA-Z]/,"").split(",")

tri_words = []

WORDS.each do |word|
	word_score = word.chars.inject(0) {|sum, char| sum + CHAR_VALUE[char]}
	tri_words << word if word_score.triangular?
end

puts tri_words.length