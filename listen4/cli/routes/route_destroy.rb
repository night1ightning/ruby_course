class Cli::RouteDestroy < Cli::BaseCommands
  def info
    super 'Удалить маршрут'
  end

  protected

  attr_reader :routes

  def params_valid?
    self.routes = keeper.get_collection_by_type(:route)
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
    destroy(id) if valid?(id)
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

  def destroy(id)
    route = routes.delete_at(id)
    keeper.set_collection_by_type(:route, routes)
    result_message "Маршрут \"#{route}\" удален\n"
  end
end

