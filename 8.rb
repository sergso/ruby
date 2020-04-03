module JetPropelled
def move(destination)
puts "Flying to #{destination}."
end
end
class Robot
def move(destination)
puts "Walking to #{destination}."
end
end
class TankBot < Robot
include JetPropelled
def move(destination)
puts "Rolling to #{destination}."
end
end
class HoverBot < Robot
include JetPropelled
end
class FarmerBot < Robot
end
TankBot.new.move("hangar")
HoverBot.new.move("lab")
FarmerBot.new.move("field")



class Foo
  def bar
    10 # любой метод возвращает значение - результат выполнения последнего выражения
  end
  def baz(a)
    bar + 20
  end
end
puts Foo.new.baz(20)
