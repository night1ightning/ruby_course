class Cli::RouteStationDestroy < Cli::BaseCommands
  def info
    super 'Удалить станцию из маршрута'
  end

  protected

  attr_reader :route, :intermediate_staions, :station

  def params_valid?
    self.route = session.get_current_object
    self.intermediate_staions = route.stations[1...-1]
    if intermediate_staions.empty?
      info_message "\nПромежуточных станций в маршруте нет"
      return false
    end
    true
  end

  def command
    Cli::StationList.new.show_table(intermediate_staions, 
      'Промежуточные станции которые можно удалить')
    print "\n№ промежуточной станции: "
    id = gets.to_i
    self.station = intermediate_staions[id]
    route.clear_point_station(station)
    update if valid?
  end

  private 

  attr_writer :route, :intermediate_staions, :station

   
  def valid?
    if station.nil?
     errors.add_msg "\n№ не верен"
     return false
    end
    route.valid? 
  end

  def update
    route.update
    result_message "Из маршрута \"#{route}\" убрали станцию \"#{station}\"\n"
  end
end

