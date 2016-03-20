class Fixnum
	def palindrome?
		self.to_s == self.to_s.reverse
	end
end

palindromes = []

999.downto 100 do |outer|
	999.downto 100 do |inner|
		product = outer*inner
		palindromes << [product, outer, inner] if product.palindrome?
	end
end

largest = palindromes.sort.last
puts "#{largest[0]} = #{largest[1]} X #{largest[2]}"