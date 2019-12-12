PASS = "pass"
CARGO = "cargo"

class Train
  @@train_number_all ||=1000
  attr_reader :train_number, :train_type, :speed, :train_route, :current_station, :vagon_count, :vagon
  attr_writer :speed, :train_route, :current_station, :vagon_count, :vagon

  def initialize
    @vagon ||=[]
    @vagon_count ||=0
    @speed ||=0
    @train_number = @@train_number_all +=1
    self.class.trains[@train_number] = self
  end
  def self.trains
    @trains ||= Hash.new
  end

  def train_number_all
    @@train_number_all
  end

  def self.train_number_all
    @@train_number_all
  end
  #увеличение скорости поезда
  def speed_up(speed_up = 0)
    @speed = @speed + speed_up
    puts "Скорость поезда увеличена до #{@speed} км/ч"
  end

  #уменьшение скорости поезда
  def speed_down(speed_down = 0)
    @speed = @speed - speed_down

    if (@speed < 0)
      @speed = 0
    end

    puts "Скорость поезда уменьшена до #{@speed} км/ч"
  end

  #отображает текущую скорость поезда
  def speed_cur
    puts "Текущая скорость поезда #{@train_number}: #{@speed} км/ч"
  end

  # отображает количество вагонов
  # def vagon_count
  #   puts "Количество вагонов в поезде #{@train_number} - #{@vagon_count} шт"
  # end

  # #подцепить вагон по 1 шт если скорость 0
  # def vagon_hook(vagon)
  #   if (vagon.vagon_type != @train_type)
  #     raise "!Не возможно подцепить вагон!\n Тип поезда #{@train_type}, тип вагона #{vagon.vagon_type} \nТип вагона не совпадает с типом поезда"
  #   end
  #   if (@speed != 0)
  #     raise "!Не возможно подцепить вагон! \nУменьшите скорость до 0. \n Текущая скорость #{@speed} км./ч"
  #   end
  #   if (@vagon.include?(vagon))
  #     raise "!Не возможно подцепить вагон! \nУказанный вагон уже подцеплен к поезду."
  #   else
  #     @vagon << vagon
  #     @vagon_count = @vagon.size
  #     puts "Вагон успешно прицеплен! Всего вагонов #{@vagon_count}"
  #   end
  # end

  # #отцепить вагон по 1 шт если скорость 0
  # def vagon_unhook(vagon)
  #   if (@speed != 0)
  #     raise "!Не возможно отцепить вагон! \nУменьшите скорость до 0. \n Текущая скорость #{@speed} км./ч"
  #   end
  #   unless (@vagon.include?(vagon))
  #     raise "!Не возможно отцепить вагон! \nУказанный вагон не подцеплен к поезду."
  #   end
  #     @vagon.delete(vagon)
  #     @vagon_count = @vagon.size
  #     puts "Вагон успешно отцеплен! Всего вагонов #{@vagon_count}"
  # end


  #Привязка поезда к маршруту
  def train_add_route(route)
    @train_route = route
    @current_station = @train_route.station["first"]
  end

  #Назначим текущую станцию
  def train_current_station(station = "no_station")
    if (@train_route == nil)
      raise "Не назначен маршрут поезда. Используйте метод train_add_route"
    end
    if (station == "no_station")
      puts "Текущая станция поезда номер #{self.train_number} - #{self.current_station.station_name}."
    elsif (@train_route.station["first"] == station)
      @current_station = station
    elsif (@train_route.station["last"] == station)
      @current_station = station
    elsif (@train_route.station["int"].include?(station))
      @current_station = station
    else
      raise "Данный маршрут не содержит станции #{station}. Используйте метод .route_station"
    end
  end

  def train_next_station
    if (@current_station == @train_route.station["first"])

      if (@train_route.station["int"].empty?)
        @current_station = @train_route.station["last"]
        puts "Вы прибыли на конечную станцию #{@current_station.station_name}"
      else
        @current_station = @train_route.station["int"][0]
        puts "Вы прибыли на станцию #{@train_route.station["int"][0].station_name}"
      end
    elsif (@current_station == @train_route.station["last"])
      puts "Текущая станция  #{@current_station.station_name} - последняя в маршруте"
      puts "Используйте метод train_prev_station для указания другой станции"
    else
      i = 0
      l = @train_route.station["int"].count - 1
      while i < @train_route.station["int"].size do
        if (@train_route.station["int"][i] == @current_station and i == l)
          @current_station = @train_route.station["last"]
          puts "Вы прибыли на конечную станцию #{@current_station.station_name}"
          break
        elsif (@train_route.station["int"][i] == @current_station and i < l)
          @current_station = @train_route.station["int"][i + 1]
          puts "Вы прибыли на станцию #{@current_station.station_name}"
          break
        end
        i += 1
      end
    end
  end
  
  def train_prev_station
    if (@current_station == @train_route.station["last"])

      if (@train_route.station["int"].empty?)
        @current_station = @train_route.station["first"]
        puts "Вы прибыли на первую станцию #{@current_station.station_name}"
      else
        @current_station = @train_route.station["int"].last
        puts "Вы прибыли на станцию #{@current_station.station_name}"
      end
    elsif (@current_station == @train_route.station["first"])
      puts "Текущая станция  #{@current_station.station_name} - первая в маршруте"
      puts "Используйте метод train_next_station для движения к другой станции"
    else
      i = 0
      while i < @train_route.station["int"].size do
        if (@train_route.station["int"][i] == @current_station and i == 0 )
          @current_station = @train_route.station["first"]
          puts "Вы прибыли на первую станцию #{@current_station.station_name}"
          break
        elsif (@train_route.station["int"][i] == @current_station )
          @current_station = @train_route.station["int"][i - 1]
          puts "Вы прибыли на станцию #{@current_station.station_name}"
          break
        end
      i += 1
      end
    end
  end

  #отобразим текущую, след. и предидущую станции
  def train_list_station
    if (@current_station == @train_route.station["first"])
      puts "Текущая станция  #{@current_station.station_name} - первая в маршруте"
      if (@train_route.station["int"].empty?)
        puts "Следующая станция - #{@train_route.station["last"].station_name} - последняя в маршруте"
      else
        puts "Следующая станция #{@train_route.station["int"][0].station_name}"
      end
    elsif (@current_station == @train_route.station["last"])
      puts "Текущая станция  #{@current_station.station_name} - последняя в маршруте"
      puts "Предыдующая станция #{@train_route.station["first"].station_name}"
    else
      i = 0
      l = @train_route.station["int"].count - 1
      while i < @train_route.station["int"].size do
        if (@train_route.station["int"][i] == @current_station and i == 0 and i == l)
          puts "Текущая станция #{@current_station.station_name}"
          puts "Предыдущая станция #{@train_route.station["first"].station_name}"
          puts "Следующая станция #{@train_route.station["last"].station_name}"
          break
        elsif (@train_route.station["int"][i] == @current_station and i == 0 and i < l)
          puts "Текущая станция #{@current_station.station_name}"
          puts "Предыдущая станция #{@train_route.station["first"].station_name}"
          puts "Следующая станция #{@train_route.station["int"][i + 1].station_name}"
          break
        elsif (@train_route.station["int"][i] == @current_station and i == l)
          puts "Текущая станция #{@current_station.station_name}"
          puts "Предыдущая станция #{@train_route.station["int"][i - 1].station_name}"
          puts "Следующая станция #{@train_route.station["last"].station_name}"
          break
        elsif (@train_route.station["int"][i] == @current_station )
          puts "Текущая станция #{@current_station.station_name}"
          puts "Предыдущая станция #{@train_route.station["int"][i - 1].station_name}"
          puts "Следующая станция #{@train_route.station["int"][i + 1].station_name}"
          break
        end
      i += 1
      end
    end
  end
  def self.find(number)

    g = nil
    self.trains.each do |k,v|
      if v.train_number == number.to_i
        puts "+ #{number}"
        g = v
        break
      end
    end
    return g
  end
end

class Train_pass < Train

  def initialize
    super
    @train_type = PASS
  end
  
end

class Train_cargo < Train

  def initialize
    @train_type = CARGO
    super
  end
end

def train_create
  train_type = 0
  until (train_type == 3) do
    puts "Создаём объект - новый поезд" 
    puts "Укажите тип поезда: (1) - для пассажирского,  (2) - для грузового, (3) - для выхода"
    train_type = gets.chomp.to_i
    case train_type
      when 1
        train = Train_pass.new
        puts "Создан объект Поезд пассажирский с номером #{train.train_number}"
        puts "Всего создано пассажирских поездов #{Train_pass.trains.size}"
        next
      when 2
        train = Train_cargo.new
        puts "Создан объект Поезд грузовой с номером #{train.train_number}"
        puts "Всего создано грузовых поездов #{Train_cargo.trains.size}"
        next

      when 3
        puts "Список созданных вагонов:"
        train_numbers(CARGO)
        train_numbers(PASS)
        puts "!!!exit!!!"
        next

      else
        puts "Не верный ввод! Используйте (1) - для пассажирского,  (2) - для грузового, (3) - для выхода"
        next
    end
  end 
end
#Метод выдаёт номера поездов по типам
def train_numbers(type)
  if (type == CARGO)
    puts "Грузовые поезда имеют следующие номера:"
    Train_cargo.trains.each do |_k,_v|
      puts "#{_v.train_number}"
    end
  elsif (type == PASS)
    puts "Пассажирские поезда имеют следующие номера:"
    Train_pass.trains.each do |key,val|
      puts "#{val.train_number}"
    end
  else 
    puts "Не верный тип поезда. Используйте \"pass\" для пассажирского и \"cargo\" для грузового поезда" 
    return false
  end
end

#Метод для ввода номера поезда

# def train_number_input_def(train_type)
#   if (train_type == "1")
#     @train_print_type = PASS
#   elsif (train_type == "2")
#     @train_print_type = CARGO
#   else
#     puts "Не верный тип поезда. Используйте \"1\" для пассажирского и \"2\" для грузового поезда" 
#     return false
#   end
#   train_number = ""
#   until (train_number == "x")
#     puts "Укажите номер поезда типа \"#{@train_print_type}\""
#     puts "Чтобы посмотреть все номера поездов типа \"#{@train_print_type}\" - нажмите (n), для выхода нажмите - (х) "
#     train_number = gets.chomp
#     case train_number
#       when "x"
#         puts "!!Exit!!"
#         next
#       when "n"
#         train_numbers(@train_print_type)
#         next
#       else
#         if @train_print_type == PASS
#           if Train_pass.trains.detect {|k,v|v.train_number == number} != nil
#             Train_pass.trains.each do |key,val|
#               if "#{val.train_number}" == train_number
#                 @train_number_input = train_number
#                 return @train_number_input
#                 break
#               end
#             end
#           else
#                 puts "Не верный номер поезда! Попробуйте еще раз"
#               next
#           end
#         elsif train_print_type == CARGO
#           if Train_cargo.trains.detect {|k,v|v.train_number == number} != nil
#             Train_cargo.trains.each do |key,val|
#               if "#{val.train_number}" == train_number
#                 @train_number_input = train_number
#                 return @train_number_input
#                 break
#               end
#             end
#           else
#             puts "Не верный номер поезда! Попробуйте еще раз"
#             next
#           end
#         end
#       end
#     end
#   end

def train_hook_vagon
  train_type = ""
  train_number = ""
  puts "Добавим вагон к поезду. Имеем следующие номера поездов"
  train_numbers(PASS)
  train_numbers(CARGO)
  until (train_number == "x")
    puts "Укажите номер поезда, для выхода нажмите (х), \n Чтобы посмотреть все номера поездов - нажмите (n) "
    train_number = gets.chomp
    case train_number
      when "x"
        puts "!!Exit!!"
        break
      when "n"
        train_numbers(PASS)
        train_numbers(CARGO)
        next
      else
        if Train_pass.trains.detect {|k,v|v.train_number == train_number.to_i} != nil
          puts "Вы выбрали пассажирский позед с номером #{train_number}"
          @train_number_input = train_number.to_i
          if (Train_pass.trains[@train_number_input].speed != 0)
            raise "!Не возможно подцепить вагон! \nУменьшите скорость до 0. \n Текущая скорость #{Train_pass.trains[@train_number_input].speed} км./ч"
          end
          vagon_hook(PASS,@train_number_input)
          Train_pass.trains[@train_number_input].vagon_count = Train_pass.trains[@train_number_input].vagon.count
        elsif Train_cargo.trains.detect {|k,v|v.train_number == train_number.to_i} != nil
          @train_number_input = train_number.to_i
          if (Train_cargo.trains[@train_number_input].speed != 0)
            raise "!Не возможно подцепить вагон! \nУменьшите скорость до 0. \n Текущая скорость #{Train_cargo.trains[@train_number_input].speed} км./ч"
          end
          puts "Вы выбрали грузовой поезд с номером #{train_number}"
          vagon_hook(CARGO,@train_number_input)
          Train_cargo.trains[@train_number_input].vagon_count = Train_cargo.trains[@train_number_input].vagon.count
        else
          puts "Не верно указан номер поезда. Попробуйте еще раз"
          next
        end
    end
  end
end
# def add_vagon(train_number,vagon_number)
#   Vagon_pass.vagons.each do |key,val|
#     puts "#{val.vagon_number}"
#     if 
#     end

#   end
# end

def train_unhook_vagon
  train_type = ""
  train_number = ""
  puts "Отцепим вагон от поезда. Имеем следующие номера поездов"
  train_numbers(PASS)
  train_numbers(CARGO)
  until (train_number == "x")
    puts "Укажите номер поезда, для выхода нажмите (х), \n Чтобы посмотреть все номера поездов - нажмите (n) "
    train_number = gets.chomp
    case train_number
      when "x"
        puts "!!Exit!!"
        break
      when "n"
        train_numbers(PASS)
        train_numbers(CARGO)
        next
      else
        if Train_pass.trains.detect {|k,v|v.train_number == train_number.to_i} != nil
          puts "Вы выбрали пассажирский позед с номером #{train_number}"
          @train_number_input = train_number.to_i
          vagon_unhook(PASS,@train_number_input)
          Train_pass.trains[@train_number_input].vagon_count = Train_pass.trains[@train_number_input].vagon.count
        elsif Train_cargo.trains.detect {|k,v|v.train_number == train_number.to_i} != nil
          @train_number_input = train_number.to_i
          puts "Вы выбрали грузовой поезд с номером #{train_number}"
          vagon_unhook(CARGO,@train_number_input)
          Train_cargo.trains[@train_number_input].vagon_count = Train_cargo.trains[@train_number_input].vagon.count
        else
          puts "Не верно указан номер поезда. Попробуйте еще раз"
          next
        end
    end
  end
end



# def train_add_vagon
#   train_type = ""
#   train_number_input = ""
#   vagon_number_input = ""
#   puts "Добавим вагон к поезду. "
#   until (train_type == "3") do
#     puts "Укажите тип поезда: (1) - для пассажирского,  (2) - для грузового, (3) - для выхода"
#     train_type = gets.chomp
#     train_type.inspect
#     if  train_type == "1" or train_type == "2"
#       train_number_input_def(train_type)
#       puts "train_number - #{@train_number_input}"
#       train_type = "3"
#       elsif train_type == "3"        
#         puts "!!!exit!!!"
#         next
#       else
#         puts "Не верный ввод! Используйте (1) - для пассажирского,  (2) - для грузового, (3) - для выхода"
#         next
#     end
#   end
  
#   until (vagon_number_input == "x")
#     puts "Укажите номер вагона. Чтобы посмотреть все номера вагонов типа \"#{@train_print_type}\" - нажмите (n),\n для выхода нажмите - (х) "
#     vagon_number_input = gets.chomp
#     case vagon_number_input
#       when "x"
#         puts "!!Exit!!"
#         next
#       when "n"
#         vagon_numbers(@train_print_type)
#         next
#       else
#         vagon_hook_m(@train_print_type,vagon_number_input.to_i)
#         next
      
#       end
#     end
#   end


# def train_vagon_hook(type,number)
# if type == CARGO
#     Vagon_cargo.vagons.each do |key,val|
#       if val.vagon_number == number
#         if val.vagon_hook == 1
#           raise "Вагон с номером #{val.vagon_number} уже прицеплен к поезду"
#         end
#       val.vagon_hook = 1
#       end
#     end

#   elsif type == PASS
#     Vagon_pass.vagons.each do |key,val|
#       if val.vagon_number == number
#         if val.vagon_hook == 1
#           raise "Вагон с номером #{val.vagon_number} уже прицеплен к поезду"
#         end
#       val.vagon_hook = 1
#       end
#     end
#   end
# end

#