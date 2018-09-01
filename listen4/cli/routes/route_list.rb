class Cli::RouteList < Cli::BaseCommands
  def info
    super 'К списку маршрутов'
  end

  def show_table(routes, title = 'Маршруты')
    if routes.empty?
      print_empty_list(title)
      return
    end
    print_list(routes, title)
  end

  protected

  attr_reader :routes

  def params_valid?
    self.routes = keeper.get_collection_by_type(:route)
    if routes.empty?
      info_message "\nНужно добавить маршруты"
      return false
    end
    true
  end

  def command
    show_table(routes)
  end

  private

  attr_writer :routes


  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(routes, title)
    rows = []
    routes.each.with_index do |route, index|
      rows << [index, route.name, route.stations.join(', ')]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['№', 'Название', 'Список станций'], 
      rows: rows
    )
    puts table
  end
end

