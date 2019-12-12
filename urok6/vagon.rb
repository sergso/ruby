PASS = "pass"
CARGO = "cargo"

module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstaceMethods
  end
  module ClassMethods
    def instances
      vagon_count_all
    end
  end
  #protected
  module InstaceMethods
    def register_instance
      up_count
    end

  end
end


class Vagon
  attr_reader :vagon_number, :vagon_type, :vagon_hook
 
  attr_writer :vagon_hook 
  @@vagon_count_all ||= 0
#  extend InstanceCounter::ClassModul
  include InstanceCounter
  private
#  include InstanceCounter::InstaceModul
  def initialize
    
    @vagon_number = @@vagon_count_all += 1
    self.class.vagons[@vagon_number] = self
    @vagon_hook = 0
  end

  def up_count
    @@vagon_count_all += 1
  end

  def vagon_count_all
    @@vagon_count_all
  end

   def self.vagon_count_all
     @@vagon_count_all
   end
  def self.vagons
    @vagons ||= Hash.new
  end
 
end

class Vagon_cargo < Vagon
  private
  def initialize
    @vagon_type = CARGO
    super
  end

end

class Vagon_pass < Vagon
  attr_accessor :places
  #private
  def initialize
    @vagon_type = PASS
    @plaсes = Array.new(100, 0)
    super
    #self.class.vagons[@vagon_number].plaсes = Array.new(100, 0)
    
  end
  def self.occupy_place(vagon,place = "any")
    
    if place == "any"
      i = 0
      while i < @places.size do
        if self.vagons[vagon].plaсes[i] == 0
          self.vagons[vagon].plaсes[i] = 1
           i +=1
          break
        end
      end
    else 
      if self.vagons[vagon].plaсes[place] == 1
        puts "Это место уже занято"
      else
        self.vagons[vagon].plaсes[place] = 1
      end
    end
  end
  #def self.places
    
 # end
end
def vagon_create
  vagon_type = 0
  until (vagon_type == 3) do
    vagon_type = 0
    puts "Создаём объект - новый вагон" 
    puts "Укажите тип вагона: (1) - для пассажирского,  (2) - для грузового, (3) - для выхода"
    vagon_type = gets.chomp.to_i
    case vagon_type
      when 1
        vagon = Vagon_pass.new
        puts "Создан объект Вагон пассажирский с номером #{vagon.vagon_number}"
        puts "Всего создано пассажирских вагонов #{Vagon_pass.vagons.size}"
        next
      when 2
        vagon = Vagon_cargo.new
        puts "Создан объект Вагон грузовой с номером #{vagon.vagon_number}"
        puts "Всего создано грузовых вагонов #{Vagon_cargo.vagons.size}"
        next

      when 3
        puts "Список созданных вагонов:"
        vagon_numbers(CARGO,"3")
        vagon_numbers(PASS,"3")
        puts "!!!exit!!!"
        next

      else
        puts "Не верный ввод! Используйте (1) - для пассажирского,  (2) - для грузового, (3) - для выхода"
        next
    end
  end 
end

def vagon_numbers(vagon_type,hook)
  if vagon_type == CARGO
    puts "Грузовые вагоны имеют следующие номера:"
    Vagon_cargo.vagons.each do |key,val|
      if hook == 0
        if val.vagon_hook == 0
          puts "#{val.vagon_number}"
        end
      elsif hook == 1
        if val.vagon_hook == 1
          puts "#{val.vagon_number}"
        end
      else
        puts "#{val.vagon_number}"
      end 
    end
  elsif vagon_type == PASS
    puts "Пассажирские вагоны имеют следующие номера:"
    Vagon_pass.vagons.each do |key,val|
      if hook == 0
        if val.vagon_hook == 0
          puts "#{val.vagon_number}"
        end
      elsif hook == 1
        if val.vagon_hook == 1
          puts "#{val.vagon_number}"
        end
      else
        puts "#{val.vagon_number}"
      end
      
    end
  else 
    puts "Не верный тип вагона"
    return
  end
end
def vagon_numbers_hook(vagon_type,number)
  if vagon_type == CARGO
    puts "К грузовому поезду #{number} прицеплены вагоны со следующими номерами:"
    Vagon_cargo.vagons.each do |key,val|
      puts "#{val.vagon_number}"
    end
  elsif vagon_type == PASS
    puts "К пассажирскому поезду #{number} прицеплены вагоны со следующими номерами:"
    Vagon_pass.vagons.each do |key,val|
      puts "#{val.vagon_number}"
    end
  else 
    puts "Не верный тип вагона"
    return
  end

end

def vagon_hook(type,train_number)
  @vagon_number_input = ""
  until (@vagon_number_input == "x")
    puts "Укажите номер вагона. Чтобы посмотреть все номера вагонов типа \"#{type}\" - нажмите (n),\n для выхода нажмите - (х) "
    @vagon_number_input = gets.chomp
    puts "#{@vagon_number_input}"
    case @vagon_number_input
      when "x"
        puts "!!Exit!!"
        next
      when "n"
        vagon_numbers(type,0)
        next
      else
        if type == CARGO
          if Vagon_cargo.vagons.detect {|k,v|v.vagon_number == @vagon_number_input.to_i} != nil
            Vagon_cargo.vagons.each do |key,val|
              if val.vagon_number == @vagon_number_input.to_i
                if val.vagon_hook == 1
                  puts "Вагон с номером #{val.vagon_number} уже прицеплен к поезду"
                  break
                end
                val.vagon_hook = 1
                Train_cargo.trains.each do |k1,v1| 
                  if k1 == train_number
                    v1.vagon << val
                  end
                end
                puts "Вагон с номером #{val.vagon_number} успешно прицеплен к поезду"
                break
              end

            end
          end

        elsif type == PASS
          if Vagon_pass.vagons.detect {|k,v|v.vagon_number == @vagon_number_input.to_i} != nil
            Vagon_pass.vagons.each do |key,val|
              if val.vagon_number == @vagon_number_input.to_i
                if val.vagon_hook == 1
                  puts "Вагон с номером #{val.vagon_number} уже прицеплен к поезду"
                  break
                end
                val.vagon_hook = 1
                Train_pass.trains.each do |k1,v1| 
                  if k1 == train_number
                    v1.vagon << val
                  end
                end
                puts "Вагон с номером #{val.vagon_number} успешно прицеплен к поезду"
                break
              end

            end
        else
          puts "Вагона с номером #{@vagon_number_input} не существует. Попробуйте снова"
          next
        end
      end
    end
  end
end


def vagon_unhook(type,train_number)
  @vagon_number_input = ''
  until (@vagon_number_input == "x")
    puts "Укажите номер вагона. Чтобы посмотреть все номера вагонов типа \"#{type}\" - нажмите (n),\n для выхода нажмите - (х) "
    @vagon_number_input = gets.chomp
    #puts "#{@vagon_number_input}"
    case @vagon_number_input
      when "x"
        puts "!!Exit!!"
        next
      when "n"
        if type == PASS
          Train_pass.trains[train_number].vagon.each {|v| puts "#{v.vagon_number}"}
        end
        if type == CARGO
          Train_cargo.trains[train_number].vagon.each {|v| puts "#{v.vagon_number}"}
        end
        next
      else
        if type == CARGO
          if Vagon_cargo.vagons.detect {|k,v|v.vagon_number == @vagon_number_input.to_i} != nil
            Vagon_cargo.vagons.each do |key,val|
              if val.vagon_number == @vagon_number_input.to_i
                if val.vagon_hook == 0
                  puts "Вагон с номером #{val.vagon_number} уже отцеплен от поезда "
                  break
                end
                val.vagon_hook = 0
                Train_cargo.trains.each do |k1,v1| 
                  if k1 == train_number
                    v1.vagon.delete_if {|a| a.vagon_number == @vagon_number_input.to_i }
                  end
                end
                puts "Вагон с номером #{val.vagon_number} успешно отцеплен от поезда"
                break
              end

            end
          end

        elsif type == PASS
          if Vagon_pass.vagons.detect {|k,v|v.vagon_number == @vagon_number_input.to_i} != nil
            Vagon_pass.vagons.each do |key,val|
              if val.vagon_number == @vagon_number_input.to_i
                if val.vagon_hook == 0
                  puts "Вагон с номером #{val.vagon_number} уже отцеплен от поезда"
                  break
                end
                val.vagon_hook = 0
                Train_pass.trains.each do |k1,v1| 
                  if k1 == train_number
                    v1.vagon.delete_if {|a| a.vagon_number == @vagon_number_input.to_i}
                  end
                end
                puts "Вагон с номером #{val.vagon_number} успешно отцеплен от поезда"
                break
              end

            end
        else
          puts "Вагона с номером #{@vagon_number_input} не существует. Попробуйте снова"
          next
        end
      end
    end
  end
end
#vagon_create