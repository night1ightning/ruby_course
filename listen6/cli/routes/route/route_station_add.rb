class Cli::RouteStationAdd < Cli::BaseCommands
  def info
    super 'Добавить станцию в маршрут'
  end

  def execute
    @available_stations = nil
    super
  end

  protected

  attr_reader :route

  def params_valid?
    self.route = session.get_current_object
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
    station = available_stations[id]
    route.take_point_station(station)
    update if valid?(station)
  end

  private 

  attr_writer :route
   
  def available_stations
    @available_stations ||= begin
      stations = Model::Station.list
      stored_stations_keys = route.stations.map(&:saved_key)
      stations.reject do |station|  
        stored_stations_keys.include? station.saved_key 
      end
    end
  end

  def valid?(station)
    if station.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    route.valid?
  end

  def update
    route.update
    result_message "В маршрут \"#{route}\" добавлена станция \"#{route.stations[-2]}\"\n"
  end
end

