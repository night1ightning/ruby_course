class Cli::RouteStationList < Cli::BaseCommands
  def info
    super 'Станции маршрутa'
  end

  protected

  def command
    route = session.get_current_object
    Cli::StationList.new.show_table(route.stations, 'Станции маршрута')
  end
end

