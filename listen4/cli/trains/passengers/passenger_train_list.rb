class Cli::PassengerTrainList < Cli::BaseCommands
  def info
    super 'К списку пасажирских поездов'
  end

  def show_table(passenger_trains, title = 'Пассажирские поезда')
    if passenger_trains.empty?
      print_empty_list(passenger_trains)
      return
    end
    print_list(passenger_trains, title)
  end

  protected

  attr_reader :passenger_trains

  def params_valid?
    trains = keeper.get_collection_by_type(:train)
    self.passenger_trains = trains.select { |train| train.type == :passenger }
    if passenger_trains.empty?
      info_message "\nНужно добавить пассажирские поезда"
      return false
    end
    true
  end

  def command
    show_table(passenger_trains)
  end

  private

  attr_writer :passenger_trains

  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(passenger_trains, title)
    rows = []
    passenger_trains.each.with_index do |train, index|
      rows << [index, train.number, train.route]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['№', 'Номер', 'Маршрут следования'], 
      rows: rows
    )
    puts table
  end
end

