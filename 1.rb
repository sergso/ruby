def delen(arg1,arg2)
	if arg2==0
		return 0.0
	end
	arg1/arg2
end

puts delen(100,25)

class Bird
def talk(name)
puts "#{name} Chirp! Chirp!"
end

def move(name, destination)
puts "#{name} Flying to the #{destination}."
end
end
class Dog
def talk(name)
puts "#{name} Bark!"
end
def move(name, destination)
puts "#{name} Running to the #{destination}."
end
end
class Cat
def talk(name)
puts "#{name} Meow!"
end
def move(name, destination)
puts "#{name} Running to the #{destination}."
end
end

class Mage
	attr_accessor :name, :spell
	def ench(target)
	puts "#{@name} idet #{@spell}"
	end
end

bird = Bird.new
dog = Dog.new
cat = Cat.new
dog_name = "Bobik"
bird_name = "Ptica"
cat_name = "Bars"
#Создание новых экземпляров классов
bird.move(bird_name,"tree")
dog.talk(dog_name,)
bird.talk(bird_name)
cat.move(cat_name,"house")
