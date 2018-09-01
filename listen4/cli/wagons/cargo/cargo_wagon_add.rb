class Cli::CargoWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить грузовой вагон'
  end

  protected

  def command
    print "\nМаксимальный вес: "
    weight = gets.to_i
    save(weight) if valid?(weight)
  end

  private

  def valid?(weight)
    if weight < 1
      error_message "\nМаксимальный вес не может быть 0 или отрицательным"
      return false
    end
    true
  end

  def save(weight)
    cargo_wagon = Model::CargoWagon.new(weight)
    wagons = keeper.get_collection_by_type(:wagon)
    wagons << cargo_wagon
    keeper.set_collection_by_type(:wagon, wagons)
    result_message "Грузовой вагон успешно добавлен\n"
  end
end

