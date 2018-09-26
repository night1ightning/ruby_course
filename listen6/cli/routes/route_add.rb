class Cli::RouteAdd < Cli::BaseCommands
  def info
    super 'Добавить маршрут'
  end

  protected

  attr_reader :stations, :route

  def params_valid?
    self.stations = Model::Station.list
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
    self.route = Model::Route.new(stations[first], stations[last])
    create if valid?
  end

  private 

  attr_writer :stations, :route

  def valid?
    route.valid?
  end
   
  def create
    route.create
    result_message "Маршрут \"#{route}\" успешно добавлен\n"
  end
end

