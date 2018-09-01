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

  def params_valid?
    self.trains = keeper.get_collection_by_type(:train)
    if trains.empty?
      info_message "\nНужно добавить поезда"
      return false
    end
    true
  end

  def command
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

