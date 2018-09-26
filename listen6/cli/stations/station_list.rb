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

  def command
    self.stations = Model::Station.list
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
      trains = station.trains || []
      rows << [index, station, trains.join(', ')]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['№', 'Название', 'Список поездов'], 
      rows: rows
    )
    puts table
  end
end

