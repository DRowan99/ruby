# Write README to explain command line switches

require 'optparse'

class Fixnum

	# Use triangular numbers to reduce the amount of addition needed to determine the sum
	# Ex: (3 + 6 + 9 + . . . + 3n) = 3*(1 + 2 + 3 + . . . + n) = 3*T_n
	# where T_n is the nth triangular number with known algebraic representation
	# T_n = n*(n+1)/2
	def sum_multiples_less_than(n)
		triang_n = (n/self) - (n % self == 0 ? 1 : 0)
		self*((triang_n)*(triang_n + 1))/2
	end
end

options = {}
opts = OptionParser.new do |create_opts|
	create_opts.banner = "Usage: pe001.rb [options]"

	create_opts.on("--less-than NUMBER", "-n", Integer,
		"Specify the number n to add up to.") {|n| options[:n] = n}

	create_opts.on("--multiples-of NUM1,[NUM2,]", "-m", Array,
		"Indicate the numbers you would like", 
		"  to count multiples of up to n.") {|list| options[:multiples_of] = list.map(&:to_i)}

	create_opts.on_tail("--help", "-h", "List the available options",
		"  and details about how they work") { puts opts; exit }
end

opts.parse! ARGV

n = (options[:n] || 1000).to_i
multiples_of = (options[:multiples_of] || [3,5]).uniq

# Remove any numbers that are divisible by other numbers in the list
# since these will be generated and counted by any divisors
multiples_of.reject!{ |m| (multiples_of - [m]).any?{|k| m % k == 0} }

result = 0
operation = [:+, :-].cycle

(1..multiples_of.length).each do |i|
	# Using inclusion-exclusion principle.
	# Change the operator on each go around from plus, to minus, to plus, . . .,
	# as you count up to n, then remove double counts from the previous step,
	# then add back in items removed by triple counts from the previous step. . .
	plus_minus = operation.next
	multiples_of.combination(i).each do |combo|
		num = combo.inject(&:*)
		result = result.send(plus_minus, num.sum_multiples_less_than(n))
	end
end

puts result
