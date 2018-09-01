class Cli::PassengerTrainWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить вагон'
  end

  protected

  attr_reader :passenger, :available_wagons

  def params_valid?
    self.passenger = keeper.get_current_object
    wagons = keeper.get_collection_by_type(:wagon)
    passenger_wagons = wagons.select { |wagon| wagon.type == :passenger }
    self.available_wagons = passenger_wagons - passenger.wagons
    if available_wagons.nil? || available_wagons.empty?
      info_message 'Нужно добавить пассажирские вагоны'
      return false
    end
    true
  end

  def command
    Cli::PassengerWagonList.new.show_table(passenger.wagons, 'Вагоны поезда')
    Cli::PassengerWagonList.new.show_table(available_wagons,
      'Список не привязанных вагонов')
    print "\n№ непривязанного вагона: "
    id = gets.to_i
    add_wagon(id) if valid?(id)
  end

  private

  attr_writer :passenger, :available_wagons

  def valid?(id)
    if available_wagons[id]
      return true
    end
    error_message "\n№ не верен"
    false
  end

  def add_wagon(id)
    wagon = available_wagons[id]
    passenger.add_wagons([wagon])
    result_message "К поезду \"#{passenger}\" добавили вагон\n"
  end
end

