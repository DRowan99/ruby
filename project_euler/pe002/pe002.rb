# Write README explaining why you can calculate every third and publish benchmarks.

def calculate_all
	fib_nums = []
	prev_term, curr_term = 1, 1
	
	begin
		fib_nums << curr_term
		prev_term, curr_term = curr_term, prev_term + curr_term
	end while prev_term < 4_000_000
	
	fib_nums.select{ |num| num.even? }.inject(&:+)
end

def calculate_every_third
	prev_term, curr_term = 2, 8
	even_fibs = [prev_term]

	begin
		even_fibs << curr_term
		prev_term, curr_term = curr_term, 4*curr_term + prev_term
	end while curr_term < 4_000_000

	even_fibs.inject(&:+)
end

require 'benchmark'

def fib_benchmark(n = 5000)
	Benchmark.bmbm(20) do |x|
		x.report("calculate each fib") {n.times do ; calculate_all ; end}
		x.report("calculate every third") {n.times do ; calculate_every_third ; end}
	end
end