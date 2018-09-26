class Cli::PassengerWagonList < Cli::BaseCommands
  def info
    super 'К списку пассажирских вагонов'
  end

  def show_table(passenger_wagons, title = 'Пассажрские вагоны')
    if passenger_wagons.empty?
      print_empty_list(title)
      return
    end
    print_list(passenger_wagons, title)
  end

  protected

  attr_reader :passenger_wagons

  def params_valid?
    self.passenger_wagons = Model::PassengerWagon.list
    if passenger_wagons.empty?
      info_message "\nНужно добавить пассажирские вагоны"
      return false
    end
    true
  end

  def command
    show_table(passenger_wagons)
  end

  private

  attr_writer :passenger_wagons

  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(passenger_wagons, title)
    rows = []
    passenger_wagons.each.with_index do |wagon, index|
      rows << [index, wagon, wagon.number_seats, wagon.train]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['№', 'Наименование', 'Количество мест', 'Поезд'], 
      rows: rows
    )
    puts table
  end
end

