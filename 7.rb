

ov = {}
line = []
File.open("1.txt") do |file|
	line = file.readlines
end
p line

line.each do |znach|
	name = znach.chomp
	if ov[name]
		ov[name] +=1
	else
		ov[name] = 1
	end
end

p ov

if false
#Настоящее» ложное значение.
puts "I won't be printed!"
end

if nil
puts "I won't, either!"
end
