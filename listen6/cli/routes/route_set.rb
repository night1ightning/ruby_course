class Cli::RouteSet < Cli::BaseCommands
  def info
    super 'Выбрать маршрут'
  end

  protected

  attr_reader :routes, :route

  def params_valid?
    self.routes = Model::Route.list
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
    self.route = routes[id]
    set_route if valid?
  end
  
  private

  attr_writer :routes, :route

  def valid?
    return true if route
    errors.add_msg "\n№ не верен"
    false
  end

  def set_route
    session.set_current_object(route, 'Маршрут')
    result_message "Маршрут \"#{route}\" выбран\n"
  end
end

