class Cli::RouteDestroy < Cli::BaseCommands
  def info
    super 'Удалить маршрут'
  end

  protected

  attr_reader :routes, :route

  def params_valid?
    self.routes = Model::Route.list
    if routes.empty?
      info_message "\nСписок маршрутов пуст"
      return false
    end
    true
  end

  def command
    Cli::RouteList.new.show_table(routes)
    print "\n№ маршрута: "
    id = gets.to_i
    self.route = routes[id]
    destroy if valid?
  end

  private 
   
  attr_writer :routes, :route

  def valid?
    if route.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    route.valid?
  end

  def destroy
    Model::Route.destroy(route)
    result_message "Маршрут \"#{route}\" удален\n"
  end
end

