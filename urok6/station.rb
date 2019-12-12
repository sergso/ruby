class Station
  attr_reader :station_number, :station_name, :station_train
  #attr_writer :station_train

  @@station_count_all ||=0 

  def initialize(station_name = "NewStation")
    @station_name = station_name
    @station_train = []
    @station_number = @@station_count_all += 1
    @@all_station ||=[]
    @@all_station << self
  end

  def self.all
    @@all_station.each {|st| puts "#{st.station_name}"}

  end

  def station_count_all
    @@station_count_all
    end

  def self.station_count_all
    @@station_count_all
  end

#Принимать поезда
  # def station_take(train)
  #   @station_train << train
  #   puts "На станцию #{station_name} прибыл поезд #{train.train_number}"
  # end

#отправка поезда
  # def station_send(train)
  #   @station_train.delete(train)
  #   puts "Со станции #{station_name} убыл поезд #{train}"
  # end

#Отобразить поезда на танции

  # def station_train
  #   puts "На станции #{station_name} находятся следующие поезда:"

  #   @station_train.each do |tr|
  #     puts "#{tr.train_number} \n"
  #   end
  #   # puts "#{st.station_train[1]}"
  # end

  def station_train_type(type = nil)
    if (type == @pass) or (type == @gruz)
      if (type == @pass)
        puts "На станции #{station_name} стоят пассажирские поезда с номерами: "
      elsif (type == @gruz)
        puts "На станции #{station_name} стоят грузовые поезда с номерами:"
      else
        raise "Не верно указан тип поезда. Используйте: \"gruz\" или \" cargo\""
      end

      @station_train.each do |tr|
        if (tr.train_type == type)
          puts "#{tr.train_number}"
        end
      end
    end
  end
end

def station_create
  $station ||=[]
  station_name = 0
  until (station_name == "3") do
    puts "Создаём объект - Железнодорожная станция" 
    puts "Укажите название станции или нажмите (3) - для выхода"
    station_name = gets.chomp
    if station_name == "3"
      puts "Список созданных станций:"  
      station_numbers
    else
      $station << Station.new(station_name)
      next
    end
  end
end

def station_numbers
  $station.each {|x| puts "#{x.station_number})#{x.station_name}"}
end

def station_trains(station)
  if station.station_train.size == 0
    puts "На станции #{station.station_name} нет поездов"
  else
    puts "На станции #{station.station_name} находятся следующие поезда:"
    station.station_train.each {|tr| puts "#{tr.train_number}"}
  end
end

def station_add_train
  @station_number_input = ''
  station_number = ''
  puts "Добавим поезд на станцию"
  puts "Список станций:"
  station_numbers
  until (station_number == "x") do
    puts "Укажите номер станции или нажмите (x) - для выхода"
    station_number = gets.chomp
    if station_number == "x"
      next
    end
    $station.each do |st|
      if st.station_number == station_number.to_i
        @station_number_input = station_number.to_i
        @station_name = st.station_name
        break
      end
    end
    if @station_number_input == station_number.to_i
      break
    else
    puts "Не правильно указан номер станции. Попробуйте еще раз"
    end
  end
  train_type = ''
  train_number = ''
  puts "Добавим поезд на станцию #{@station_name}. Имеем следующие номера поездов"
  train_numbers(PASS)
  train_numbers(CARGO)
  station_trains($station[@station_number_input - 1])

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
        station_trains($station[@station_number_input - 1])
        next
      else
        if Train_pass.trains.detect {|k,v| v.train_number == train_number.to_i} != nil
          puts "Вы выбрали пассажирский позед с номером #{train_number}"
          @train_number_input = train_number.to_i
          $station.each do |st|
            if (st.station_train.detect {|s| s.train_number == @train_number_input} != nil)
              puts "Такой поезд уже на станции #{@station_name}"
              break
            else
              station_take(@station_number_input,Train_pass.trains[@train_number_input])
              break
            end
          end
        elsif Train_cargo.trains.detect {|k,v| v.train_number == train_number.to_i} != nil
          @train_number_input = train_number.to_i
          puts "Вы выбрали грузовой поезд с номером #{train_number}"
          $station.each do |st|
            if st.station_train.detect {|s| s.train_number == @train_number_input} != nil
              puts "Такой поезд уже на станции #{@station_name}"
              break
            else
              station_take(@station_number_input,Train_cargo.trains[@train_number_input])
              break
            end
          end
        else
          puts "Не верно указан номер поезда. Попробуйте еще раз"
          next
        end
    end
  end

end

def station_send_train
  @station_number_input = ''
  station_number = ''
  puts "Отправим поезд со станции"
  puts "Список станций:"
  station_numbers
  until (station_number == "x") do
    puts "Укажите номер станции или нажмите (x) - для выхода"
    station_number = gets.chomp
    if station_number == "x"
      next
    end
    $station.each do |st|
      if st.station_number == station_number.to_i
        @station_number_input = station_number.to_i
        @station_name = st.station_name
        break
      end
    end
    if @station_number_input == station_number.to_i
      break
    else
    puts "Не правильно указан номер станции. Попробуйте еще раз"
    end
  end
  train_type = ''
  train_number = ''
  puts "Отправим поезд со станции #{@station_name}. Имеем следующие номера поездов на станции"
  station_trains($station[@station_number_input - 1])

  until (train_number == "x")
    puts "Укажите номер поезда, для выхода нажмите (х), \n Чтобы посмотреть все номера поездов - нажмите (n) "
    train_number = gets.chomp
    case train_number
      when "x"
        puts "!!Exit!!"
        break
      when "n"
        station_trains($station[@station_number_input - 1])
        next
      else
        if Train_pass.trains.detect {|k,v| v.train_number == train_number.to_i} != nil
          puts "Вы выбрали пассажирский позед с номером #{train_number}"
          @train_number_input = train_number.to_i
          $station.each do |st|
            if st.station_train.detect {|s| s.train_number == @train_number_input} != nil
              station_send(@station_number_input,Train_pass.trains[@train_number_input])
              break
            else
              puts "Такого поезда нет на станции #{@station_name}"
              break
            end
          end
        elsif Train_cargo.trains.detect {|k,v| v.train_number == train_number.to_i} != nil
          @train_number_input = train_number.to_i
          puts "Вы выбрали грузовой поезд с номером #{train_number}"
          $station.each do |st|
            if st.station_train.detect {|s| s.train_number == @train_number_input} != nil
              station_send(@station_number_input,Train_cargo.trains[@train_number_input])
              break
            else
              puts "Такой поезда нет на станции #{@station_name}"
              break
            end
          end
        else
          puts "Не верно указан номер поезда. Попробуйте еще раз"
          next
        end
    end
  end

end

#Принимать поезда
def station_take(station,train)
  $station.each do |st|
    if st.station_number == station
      st.station_train << train
      break
    end
  end
  puts "На станцию #{station} прибыл поезд #{train.train_number}"
end

#Отправка поезда
def station_send(station,train)
  $station.each do |st|
    if st.station_number == station
      st.station_train.delete(train)
      break
    end
  end
  puts "Со станции #{station} убыл поезд #{train.train_number}"
end

#Посмотреть поезда на станции
def station_list_train
  @station_number_input = ''
  station_number = ''
  puts "Просмотрим список поездов на станции"
  puts "Список станций:"
  station_numbers
  until (station_number == "x") do
    puts "Укажите номер станции или нажмите (x) - для выхода"
    station_number = gets.chomp
    if station_number == "x"
      next
    end
    $station.each do |st|
      if st.station_number == station_number.to_i
        @station_number_input = station_number.to_i
        @station_name = st.station_name
        break
      end
    end
    if @station_number_input != station_number.to_i
      puts "Не правильно указан номер станции. Попробуйте еще раз"
      next
    end
    
  puts "На станции #{@station_name} находятся следующие номера поездов:"
  station_trains($station[@station_number_input - 1])
  end
    

end
