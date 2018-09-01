class Cli::RouteSet < Cli::BaseCommands
  def info
    super 'Выбрать маршрут'
  end

  protected

  attr_reader :routes

  def params_valid?
    self.routes = keeper.get_collection_by_type(:route)
    if routes.empty?
      info_message "\nНужно иметь маршруты"
      return false
    end
    true
  end

  def command
    Cli::RouteList.new.show_table(routes)
    print "\n№ маршрута: "
    id = gets.to_i
    set_route(id) if valid?(id)
  end
  
  private

  attr_writer :routes

  def valid?(id)
    if routes[id]
      return true
    end
    error_message "\n№ не верен"
    false
  end

  def set_route(id)
    route = routes[id]
    keeper.set_current_object(route, 'Маршрут')
    result_message "Маршрут \"#{route}\" выбран\n"
  end
end

