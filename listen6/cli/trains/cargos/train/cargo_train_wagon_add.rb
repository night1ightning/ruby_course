class Cli::CargoTrainWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить вагон'
  end

  protected

  attr_reader :cargo_train

  def params_valid?
    self.cargo_train = session.get_current_object
    if available_wagons.nil? || available_wagons.empty?
      info_message 'Нужно добавить грузовые вагоны'
      return false
    end
    true
  end

  def command
    Cli::CargoWagonList.new.show_table(cargo_train.wagons, 'Вагоны поезда')
    Cli::CargoWagonList.new.show_table(available_wagons,
      'Список не привязанных вагонов')
    print "\n№ непривязанного вагона: "
    id = gets.to_i
    wagon = available_wagons[id]
    cargo_train.add_wagons([wagon])
    add_wagon if valid?(wagon)
  end

  private

  attr_writer :cargo_train

  def available_wagons
    @available_wagons ||= begin
      wagons = Model::CargoWagon.list
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
    cargo_train.valid?
  end

  def add_wagon
    cargo_train.update
    result_message "К поезду \"#{cargo_train}\" добавили вагон\n"
  end
end

