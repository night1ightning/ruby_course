class Cli::CargoTrainList < Cli::BaseCommands
  def info
    super 'К списку грузовых поездов'
  end

  def show_table(cargo_trains, title = 'Грузовые поезда')
    if cargo_trains.empty?
      print_empty_list(cargo_trains)
      return
    end
    print_list(cargo_trains, title)
  end

  protected

  attr_reader :cargo_trains

  def command
    self.cargo_trains = Model::CargoTrain.list
    show_table(cargo_trains)
  end

  private

  attr_writer :cargo_trains

  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(cargo_trains, title)
    rows = []
    cargo_trains.each.with_index do |train, index|
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

