class Cli::CargoWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить грузовой вагон'
  end

  protected

  attr_reader :cargo_wagon

  def command
    print "\nМаксимальный вес: "
    weight = gets.to_i
    self.cargo_wagon = Model::CargoWagon.new(weight)
    create if valid?
  end

  private

  attr_writer :cargo_wagon

  def valid?
    cargo_wagon.valid?
  end

  def create
    cargo_wagon.create
    result_message "Грузовой вагон успешно добавлен\n"
  end
end

