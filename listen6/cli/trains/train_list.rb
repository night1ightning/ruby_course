class Cli::TrainList < Cli::BaseCommands
  def info
    super 'К общему списку поездов'
  end

  def show_table(trains, title = 'Поезда')
    if trains.empty?
      print_empty_list(title)
      return
    end
    print_list(trains, title)
  end

  protected

  attr_reader :trains

  def command
    self.trains = [
      Model::CargoTrain.list, 
      Model::PassengerTrain.list
    ].flatten
    show_table(trains)
  end

  private

  attr_writer :trains

  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(trains, title)
    rows = []
    trains.each.with_index do |train, index|
      rows << [index, train.type, train.number, train.route]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['Id', 'Тип', 'Номер', 'Маршрут следования'], 
      rows: rows
    )
    puts table
  end
end

