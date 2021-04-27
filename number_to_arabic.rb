def ar_number_to_voice(number)

	case number
	     when /^0./
		return ar_number_to_voice(number[1..-1])
	     when /^\d$/ #\d means [0-9]
	        return "digits/#{number}" 	
	     when /^1[1-9]$/ 
		return "digits/#{number}"
	     when /^[1-9]0$/
		return "digits/#{number}"
	     when /^[2-9][1-9]$/ 
		return "digits/#{number[1..1]} digits/and digits/#{number[0..0]}0"
	     when /^[1-2]00$/ #three digits ; hundredes start here
		return "digits/#{number}"
             when /^[3-9]00$/ 	     
		return "digits/#{number[0..0]} digits/100"
	     when /^[1-2]\d\d$/
		return "digits/#{number[0..0]}00 digits/and "+ar_number_to_voice(number[1..-1])
	     when /^[3-9]\d\d$/
	        return "digits/#{number[0..0]} digits/100 digits/and "+ar_number_to_voice(number[1..-1])
	      

	     when /^[1-2]000$/ #four digits ; Thousands start here
		return "digits/#{number}" 
	     when /^[3-9]000$/ 
		return "digits/#{number[0..0]} digits/1000"
	     when /^[1-2]\d\d\d$/
		return "digits/#{number[0..0]}000 digits/and "+ar_number_to_voice(number[1..-1])
	     when /^[3-9]\d\d\d$/
		return "digits/#{number[0..0]} digits/1000 digits/and "+ar_number_to_voice(number[1..-1])
	     when /^\d\d000$/ #five digits
	        return ar_number_to_voice(number[0..1])+" digits/1000"
	     when /^\d\d\d\d\d$/
	        return ar_number_to_voice(number[0..1])+" digits/1000 digits/and "+ar_number_to_voice(number[2..-1])
	     when /^\d\d\d000$/ #six digits
		return ar_number_to_voice(number[0..2])+" digits/1000"
	     when /^\d\d\d\d\d\d$/ 
		return ar_number_to_voice(number[0..2])+" digits/1000 digits/and "+ar_number_to_voice(number[3..-1])

	     when /^1000000$/ #seven digits
		return "digits/million"
	     when /^\d000000$/
		return "digits/#{number[0..0]} digits/million"
	     when /^1\d\d\d\d\d\d$/
		return "digits/million digits/and "+ar_number_to_voice(number[1..-1])
	     when /^\d\d\d\d\d\d\d$/
		return "digits/#{number[0..0]} digits/million digits/and "+ar_number_to_voice(number[1..-1])
	     when /^\d\d000000$/ #eight digits
		return ar_number_to_voice(number[0..1])+" digits/million"
	     when /^\d\d\d\d\d\d\d\d$/
		return ar_number_to_voice(number[0..1])+" digits/million  digits/and "+ar_number_to_voice(number[2..-1])
	     when /^\d\d\d000000$/#nine digits
		return ar_number_to_voice(number[0..2])+" digits/million"
	     when /^\d\d\d\d\d\d\d\d\d$/
	        return ar_number_to_voice(number[0..2])+" digits/million digits/and "+ar_number_to_voice(number[3..-1])

	     when /^1000000000$/
		return "digits/billion"
	     when /^\d000000000/
		return "digits/#{number[0..0]} digits/billion"
	     when /^1\d\d\d\d\d\d\d\d\d$/
		return "digits/billion digits/and "+ar_number_to_voice(number[1..-1])
	     when /^\d\d\d\d\d\d\d\d\d\d$/
		return "digits/#{number[0..0]} digits/billion digits/and "+ar_number_to_voice(number[1..-1])
	     when /^\d\d000000000$/
		return ar_number_to_voice(number[0..1])+" digits/billion"
	     when /^\d\d\d\d\d\d\d\d\d\d\d$/
		 return ar_number_to_voice(number[0..1])+" digits/billion  digits/and "+ar_number_to_voice(number[2..-1])
             when /^\d\d\d000000000$/
		 return ar_number_to_voice(number[0..2])+" digits/billion"
	     when /^\d\d\d\d\d\d\d\d\d\d\d\d$/
		 return ar_number_to_voice(number[0..2])+" digits/billion  digits/and "+ar_number_to_voice(number[3..-1])
	     else
		return false
	end
		
end

puts ar_number_to_voice("4434")
puts "4434"
