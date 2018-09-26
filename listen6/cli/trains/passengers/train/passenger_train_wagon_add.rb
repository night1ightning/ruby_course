class Cli::PassengerTrainWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить вагон'
  end

  protected

  attr_reader :passenger_train

  def params_valid?
    self.passenger_train = session.get_current_object
    if available_wagons.nil? || available_wagons.empty?
      info_message 'Нужно добавить пассажирские вагоны'
      return false
    end
    true
  end

  def command
    Cli::PassengerWagonList.new.show_table(passenger_train.wagons, 'Вагоны поезда')
    Cli::PassengerWagonList.new.show_table(available_wagons,
      'Список не привязанных вагонов')
    print "\n№ непривязанного вагона: "
    id = gets.to_i
    wagon = available_wagons[id]
    add_wagon if valid?(wagon)
  end

  private

  attr_writer :passenger_train

  def available_wagons
    @available_wagons ||= begin
      wagons = Model::PassengerWagon.list
      stored_wagons_keys = cargo_train.wagons.map(&:saved_key)
      wagons.reject do |wagon|
        stored_wagons_keys.include? wagon.saved_key
      end
    end
  end
  def valid?(wagon)
    if wagon.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    passenger_train.valid?
  end

  def add_wagon
    passenger_train.update
    result_message "К поезду \"#{passenger_train}\" добавили вагон\n"
  end
end

