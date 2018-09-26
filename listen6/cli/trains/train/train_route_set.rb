class Cli::TrainRouteSet < Cli::BaseCommands
  def info
    super 'Выбрать маршрут следования'
  end

  protected

  attr_reader :routes, :train, :route

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
    self.train = session.get_current_object
    train.set_route(route)
    set_route if valid?
  end

  private

  attr_writer :routes, :train, :route

  def valid?
    if route.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    train.valid?
  end

  def set_route
    train.update
    result_message "К поезду \"#{train}\" добавили маршрут \"#{route}\"\n"
  end
end

