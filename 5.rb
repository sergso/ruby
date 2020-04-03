=begin
def triple_block_result
puts 3 * yield
end
triple_block_result { 2 }
triple_block_result { 5 }


def alert_if_true
if yield
puts "Block returned true!"
else
puts "Block returned false."
end


end
alert_if_true { 2 + 2 == 5 }
alert_if_true { 2 > 1 }
=end

lines = []
File.open("/home/localadm/4.rb") do |l|
	lines = l.readlines
end
#p lines
find1 = lines.find_all { |line| line.include?("format")}

def find_word(string)
	words = string.split(" ")
	index = words.find_index('puts')
	words[index+1]
end

vyvod = find1.map do |slovo|
	vyvod = find_word(slovo).capitalize
	
end

puts vyvod

	
	
