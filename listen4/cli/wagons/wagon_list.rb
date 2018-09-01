class Cli::WagonList < Cli::BaseCommands
  def info
    super 'К общему списку вагонов'
  end

  def show_table(wagons, title = 'Вагоны')
    if wagons.empty?
      print_empty_list(title)
      return
    end
    print_list(wagons, title)
  end

  protected

  attr_reader :wagons

  def params_valid?
    self.wagons = keeper.get_collection_by_type(:wagon)
    if wagons.empty?
      info_message "\nНужно добавить вагоны"
      return false
    end
    true
  end

  def command
    show_table(wagons)
  end

  private

  attr_writer :wagons

  def print_empty_list(title)
    table = Terminal::Table.new(
      headings:  [title],
      rows: [['Список пуст']]
     )
    puts table
  end

  def print_list(wagons, title)
    rows = []
    wagons.each.with_index do |wagon, index|
      rows << [index, wagon.type, wagon.train]
    end
    table = Terminal::Table.new(
      title: title, 
      headings:  ['№', 'Тип', 'Поезд'], 
      rows: rows
    )
    puts table
  end
end

