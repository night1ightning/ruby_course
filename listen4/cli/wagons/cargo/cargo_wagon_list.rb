class Cli::CargoWagonList < Cli::BaseCommands
  def info
    super 'К списку грузовых вагонов'
  end

  def show_table(cargo_wagons, title = 'Грузовые вагоны')
    if cargo_wagons.empty?
      print_empty_list(title)
      return
    end
    print_list(cargo_wagons, title)
  end

  protected

  attr_reader :cargo_wagons

  def params_valid?
    wagons = keeper.get_collection_by_type(:wagon)
    self.cargo_wagons = wagons.select { |wagon| wagon.type == :cargo }
    if cargo_wagons.empty?
      info_message "\nНужно добавить грузовые вагоны"
      return false
    end
    true
  end

  def command
    show_table(cargo_wagons)
  end
  
  private

  attr_writer :cargo_wagons

  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(cargo_wagons, title)
    rows = []
    cargo_wagons.each.with_index do |wagon, index|
      rows << [index, wagon.type, wagon.maximum_weight, wagon.train]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['№', 'Тип', 'Максимальный вес', 'Поезд'], 
      rows: rows
    )
    puts table
  end
end

