class Station
  attr_accessor :station_name

  def initialize(station_name = "NewStation")
    @station_name = station_name
    @station_train = []
    @pass = "pass"
    @gruz = "gruz"
  end

#Принимать поезда
  def station_take(train)
    @station_train << train
    puts "На станцию #{station_name} прибыл поезд #{train.train_number}"
  end

#отправка поезда
  def station_send(train)
    @station_train.delete(train)
    puts "Со станции #{station_name} убыл поезд #{train}"
  end

#Отобразить поезда на танции

  def station_train
    puts "На станции #{station_name} находятся следующие поезда:"

    @station_train.each do |tr|
      puts "#{tr.train_number} \n"
    end
    # puts "#{st.station_train[1]}"
  end

  def station_train_type(type = nil)
    if (type == @pass) or (type == @gruz)
      if (type == @pass)
        puts "На станции #{station_name} стоят пассажирские поезда с номерами: "
      elsif (type == @gruz)
        puts "На станции #{station_name} стоят грузовые поезда с номерами:"
      else
        raise "Не верно указан тип поезда. Используйте: \"gruz\" или \" pass\""
      end

      @station_train.each do |tr|
        if (tr.train_type == type)
          puts "#{tr.train_number}"
        end
      end
    end
  end
end


class Train
  attr_accessor :train_number, :train_type, :vagon, :speed, :train_route, :current_station

  def initialize(train_number = 0, train_type = "pass", vagon = 1)
    @train_number = train_number.to_i
    # @train_route = nil

    if (train_type == "pass" or train_type == "gruz")
      @train_type = train_type
    else
      raise "Не верный тип поезда! Используйте \"pass\" или \"gruz\""
    end

    @vagon = vagon
    @speed = 0
  end

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
        i = i +1
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
        i = i + 1
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
        i = i +1
      end


    end


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
    puts "Текущая скорость  #{@number}: #{@speed} км/ч"
  end

  # отображает количество вагонов
  def vagon_count
    puts "Количество вагонов в поезде #{@number} - #{@vagon} шт"
  end

  #подцепить вагон по 1 шт если скорость 0
  def vagon_hook
    if (@speed == 0)
      @vagon += 1
      puts "Вагон успешно прицеплен! Всего вагонов #{@vagon}"
    else
      puts "!Не возможно подцепить вагон! \nУменьшите скорость до 0. \n Текущая скорость #{@speed} км./ч"
    end

  end

  #отцепить вагон по 1 шт если скорость 0
  def vagon_unhook
    if (@speed == 0)
      @vagon -= 1
      puts "Вагон успешно отцеплен! Всего вагонов #{@vagon}"
    else
      puts "!Не возможно отцепить вагон! /nУменьшите скорость до 0. /n Текущая скорость #{@speed} км./ч"
    end

  end

end


class Route
  attr_accessor :station
  def initialize(first_station = "FirstStation", last_station = "LastStation")
    @station = {}
    @station["first"] = first_station
    @station["int"] = []
    @station["last"] = last_station
  end
  def include_station(st)
    if (st == @station["first"] or st == @station["last"])
      return true
    elsif (@station["int"].include?(st))
      return true
    else 
      return false
    end

  end

  def route_add_station(add_station)

    unless (include_station(add_station))
      @station["int"] << add_station
    else
      puts "Станция #{add_station.station_name} уже присутствует в маршруте "
    end

  end

  def route_del_station(del_station)
    if (include_station(del_station) and del_station != @station["first"] and del_station != @station["last"])
      @station["int"].delete(del_station)
      puts "Из маршрута удалена станция #{del_station.station_name}"
    else
      puts "Не возможно удалить данную станцию из маршрута"
    end
  end

  def route_station
    puts "Маршрут имеет следующие станции:"
    puts "#{@station["first"].station_name}"

    @station["int"].each do |st|
      puts st.station_name
#      puts  st
    end

    puts "#{@station["last"].station_name}"
  end

end

#Создали новые объекты - поезда
tr1 = Train.new(1001)
tr2 = Train.new(1002, "gruz")
tr3 = Train.new(1003)

#создаём объект - станция
st1 = Station.new("Moskva")
st2 = Station.new("Piter")
st3 = Station.new("KRD")
st4 = Station.new("Novgorod")
st5 = Station.new("Egorievsk")
st6 = Station.new("Yaroslavl")

#Добавляем поезда на станцию
st1.station_take(tr1)
st1.station_take(tr2)
st1.station_take(tr3)

#Отображаем списк всех поездов
st1.station_train
#Отображаем списк всех поездов по типам
st1.station_train_type("gruz")
st1.station_train_type("pass")

r1 = Route.new(st1, st4)
r2 = Route.new(st3, st6)
r1.route_add_station(st2)
r1.route_add_station(st3)
r2.route_add_station(st4)
r2.route_add_station(st5)
r1.route_station

tr1.train_add_route(r1)
tr2.train_add_route(r2)


puts "----"
tr1.train_list_station
tr1.train_next_station
tr1.train_next_station


tr1.train_prev_station
tr1.train_prev_station
