class Cli::RouteStationAdd < Cli::BaseCommands
  def info
    super 'Добавить станцию в маршрут'
  end

  protected

  attr_reader :route, :available_stations

  def params_valid?
    self.route = keeper.get_current_object
    stations = keeper.get_collection_by_type(:station)
    self.available_stations = stations - route.stations
    if available_stations.empty?
      info_message "\nНужно добавить станции"
      return false
    end
    true
  end

  def command
    Cli::StationList.new.show_table(route.stations, 'Станции маршрута')
    Cli::StationList.new.show_table(available_stations, 
      'Список не привязанных станций')

    print "\n№ непривязанной станции: "
    id = gets.to_i
    save(id) if valid?(id)
  end

  private 

  attr_writer :route, :available_stations
   

  def valid?(id)
    if available_stations[id]
      return true
    end
    error_message "\n№ не верен"
    false
  end

  def save(id)
    station = available_stations[id]
    route.take_point_station(station)
    result_message "В маршрут \"#{route}\" добавлена станция \"#{station}\"\n"
  end
end

