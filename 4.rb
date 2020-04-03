#  4.rb
#  
#  Copyright 2018 localadm <localadm@vst-u11>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

class Parent
	
attr_accessor :last_name
	
def initialize(last_name)
	
@last_name = last_name
	
end
	end
	
	
class Child < Parent
	end
	
	
child = Child.new("Smith")
	
puts child.last_name

def total(sum)
	amount = 0
	index = 0
	while index < sum.size
		amount +=sum[index]
		index +=1
	end
	amount

end
sum = [10,20,35,75.5,25,4,45,8,58.58]
puts format("Summa price: %.2f", total(sum))

def t1(s)
	am=0
	s.each do |index|
		am+=index
	end
	am
end

s = [10,20,35,75.5,25,4,45,8,58.58]
puts format("Summa price: %.2f", t1(s))


def wire 
	yield "Current"
end 
wire {|power| puts "Using #{power} to turn drill bit"}
wire {|power| puts "Using #{power} to turn spin mixer"}


