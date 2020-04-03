class Station
  attr_reader :station_number, :station_name

  @@station_count_all ||=0 

  def initialize(station_name = "NewStation")
    @station_name = station_name
    @station_train = []
    @pass = PASS
    @gruz = CARGO
    @station_number = @@station_count_all += 1
  end

  def station_count_all
    @@station_count_all
    end

  def self.station_count_all
    @@station_count_all
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