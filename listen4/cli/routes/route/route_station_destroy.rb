class Cli::RouteStationDestroy < Cli::BaseCommands
  def info
    super 'Удалить станцию из маршрута'
  end

  protected

  attr_reader :route, :intermediate_staions

  def params_valid?
    self.route = keeper.get_current_object
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
    delete(id) if valid?(id)
  end

  private 

  attr_writer :route, :intermediate_staions

   
  def valid?(id)
     if intermediate_staions[id] 
       return true
     end
     error_message "\n№ не верен"
     false
  end

  def delete(id)
    station = intermediate_staions[id]
    route.clear_point_station(station)
    result_message "Из маршрута \"#{route}\" убрали станцию \"#{station}\"\n"
  end
end

