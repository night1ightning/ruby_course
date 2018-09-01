class Cli::StationList < Cli::BaseCommands
  def info
    super('К списку станций')
  end

  def show_table(stations, title = 'Станции')
    if stations.empty?
      print_empty_list(title)
      return
    end
    print_list(stations, title)
  end

  protected

  attr_reader :stations

  def params_valid?
    self.stations = keeper.get_collection_by_type(:station)
    if stations.empty?
      info_message "\nНужно добавить станции"
      return false
    end
    true
  end

  def command
    print "Переходим к списку станций\n\n"
    show_table(stations)
  end
  
  private 

  attr_writer :stations

  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(stations, title)
    rows = []
    stations.each.with_index do |station, index|
      rows << [index, station, station.trains.join(', ')]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['№', 'Название', 'Список поездов'], 
      rows: rows
    )
    puts table
  end
end

