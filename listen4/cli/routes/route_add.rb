class Cli::RouteAdd < Cli::BaseCommands
  def info
    super 'Добавить маршрут'
  end

  protected

  attr_reader :stations

  def params_valid?
    self.stations = keeper.get_collection_by_type(:station)
    if stations.size < 2
      info_message "\nНужно как минимум 2 станции"
      return false
    end
    true
  end

  def command
    Cli::StationList.new.show_table(stations)
    print "\n№ станции отправления: "
    first = gets.to_i
    print "\n№ станции прибытия: "
    last = gets.to_i
    stations_ids = [first, last].uniq
    if valid?(stations_ids)
      save(stations_ids)
    end
  end

  private 

  attr_writer :stations

  def valid?(stations_ids)
    if stations_ids.size < 2
      error_message "\nВы ввели одинаковые номера"
      return false
    end
    first, last = stations_ids
    if stations[first] && stations[last]
      return true
    end
    error_message "\nВы ввели неверный №"
    false
  end
   
  def save(stations_ids)
    first, last = stations_ids
    route = Model::Route.new(stations[first], stations[last])
    routes = keeper.get_collection_by_type(:route)
    routes << route
    routes = keeper.set_collection_by_type(:route, routes)
    result_message "Маршрут \"#{route}\" успешно добавлен\n"
  end
end

