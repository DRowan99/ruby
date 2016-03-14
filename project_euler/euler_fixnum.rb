# TODO: Make into Fixnum proxy class inside of Euler namespace,
#       and write README.

class Fixnum
	def factors
		([1] + proper_factors + [self]).sort.uniq
	end

	def is_prime?
		return false if self <= 1
		(2..(self/2)).each {|num| return false if self % num == 0}
		true
	end
	alias_method :prime?, :is_prime?

	def palindrome?
		self.to_s == self.to_s.reverse
	end

	def prime_factors
		factors.select{|factor| factor.is_prime?} 
	end

	def prime_factorization
		result = []
		prime_factors.each do |factor|
			n = 1
			until self % factor**(n+1) != 0 do
				n += 1
			end
			result << [factor]*n
		end
		result
	end

	def proper_factors
		(2..(self/2)).select{|num| self % num == 0}
	end

	# Use triangular numbers to reduce the amount of addition needed to determine the sum
	# Ex: (3 + 6 + 9 + . . . + 3n) = 3*(1 + 2 + 3 + . . . + n) = 3*T_n
	# where T_n is the nth triangular number with known algebraic representation
	# T_n = n*(n+1)/2
	def sum_multiples_less_than(n)
		nth_tri = (n/self) - (n % self == 0 ? 1 : 0)
		self*(nth_tri)*(nth_tri + 1)/2
	end

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