#  2.rb
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


class Dog
	attr_reader :name, :age
	
	def name=(value)
		if value == ""
			raise "Error!!! name blank!"
		end
		@name = value
	end
	
	def age=(value)
		if value <0
			raise "Error!!! Agw #{value} is invalid!"
		end
		@age = value
	end

def move(destination)
puts "#{@name} Running to the #{destination}."
end
def talk
puts "#{@name} say Bark!"
end
def report_age
	puts "#{@name} is #{@age} years"
end


end
dog = Dog.new
dog.name = "Bobik"
dog.age = 5
dog.report_age
dog.talk
dog.move("derevo")
