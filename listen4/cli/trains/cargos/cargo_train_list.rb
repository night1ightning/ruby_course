class Cli::CargoTrainList < Cli::BaseCommands
  def info
    super 'К список грузовых поездов'
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

  def params_valid?
    trains = keeper.get_collection_by_type(:train)
    self.cargo_trains = trains.select { |train| train.type == :cargo }
    if cargo_trains.empty?
      info_message "\nНужно добавить грузовые поезда"
      return false
    end
    true
  end

  def command
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

