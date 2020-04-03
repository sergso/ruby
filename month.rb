month = {"yanv" =>31, "fevral"=>28, "mart"=>31, "aprel" => 30, "iun"=>30, "iul"=>31, "aug"=>31, "sent"=>30, "okt"=>31, "noyabr" =>30, "dec"=>31}
month.each do |key, value|
	if value == 30
		puts "Month 30 day - #{key}"
	end
	
end

i = 10
a = []
while i <=100
	a << i
	i += 5
	
end
p a
n = 0
h = {}
b = ("а".."я")
gl = ["а","о","э","ы","у","е","я","и","ю","ё",]
b.each do |x| 
	n +=1
	if gl.include?(x) 
		h[x] = n
	end

end
arr = ("a".."z").to_a
p h

