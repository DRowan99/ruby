PE022_DIR = File.expand_path(File.dirname(__FILE__))

# Read the names from the file, remove all characters besides commas and letters, 
# split on comma to array, and sort alphabetically
NAMES = File.read(PE022_DIR + '/pe022_names.txt').gsub(/[^,a-zA-Z]/,"").split(",").sort

# Create a dictionary to lookup the score for a letter based on it alphabetical position
CHAR_VALUE = ("A".."Z").each_with_index.inject({}) {|result,(letter,i)| result[letter] = i+1; result}

result = NAMES.each_with_index.reduce(0) do |total_score,(name,i)| 
	# Add to total_score the name_score multiplied by the sorted position in the list. (i begins at 0.)
	total_score + (i+1)*(name.upcase.chars.reduce(0) {|name_score,char| name_score + CHAR_VALUE[char]})
end

puts result