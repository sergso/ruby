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