class Cli::CargoTrainWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить вагон'
  end

  protected

  attr_reader :cargo, :available_wagons

  def params_valid?
    self.cargo = keeper.get_current_object
    wagons = keeper.get_collection_by_type(:wagon)
    cargo_wagons = wagons.select { |wagon| wagon.type == :cargo }
    self.available_wagons = cargo_wagons - cargo.wagons
    if available_wagons.nil? || available_wagons.empty?
      info_message 'Нужно добавить грузовые вагоны'
      return false
    end
    true
  end

  def command
    Cli::CargoWagonList.new.show_table(cargo.wagons, 'Вагоны поезда')
    Cli::CargoWagonList.new.show_table(available_wagons,
      'Список не привязанных вагонов')
    print "\n№ непривязанного вагона: "
    id = gets.to_i
    add_wagon(id) if valid?(id)
  end

  private

  attr_writer :cargo, :available_wagons

  def valid?(id)
    if available_wagons[id]
      return true
    end
    error_message "\n№ не верен"
    false
  end

  def add_wagon(id)
    wagon = available_wagons[id]
    cargo.add_wagons([wagon])
    result_message "К поезду \"#{cargo}\" добавили вагон\n"
  end
end

