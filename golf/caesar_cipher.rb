# Ruby Golf Hole #2 from www.sitepoint.com/ruby-golf/
# Problem: Implement a Caesar Shift Cipher.
# Example: caesar("hello",3) => "khoor"
# You should also be able to produce negative shifts

# SOLUTION
# This solution implements the Caesar Shift Cipher with some basic edge case handling
# which is seemingly desirable. Argument w is the word or expression to be ciphered,
# while s is the shift which may be any integer, positive or negative.
# Ex: 	caesar "hello", 3 	=> "khoor"
# 		caesar "hello", -3 	=> "ebiil"
#
# The shift will 'wrap around' the alphabet if the last letter of the alphabet (a or z, 
# depending on the direction of the shift) is reached. Additionally, the case of each 
# character is preserved, i.e. uppercase letters will remain uppercase after they are shifted.
# Ex: 	caesar "Augustus Shiftus Caesar", -1 	=> "Ztftrstr Rghestr Bzdrzq"

# Additionally, this cipher will only shift characters in [a-zA-Z]; any other characters, 
# such as punctuation, will be 'skipped' and output by the cipher the same as they went in.
# Ex: 	caesar "Hello!", 1 	=> "Ifmmp!"

def caesar(w,s)
	w.bytes.map{|b|k=b>90?97:65;([*65..90]+[*97..122]).index(b)?k+(b-k+s)%26:b}.pack('c*')
end