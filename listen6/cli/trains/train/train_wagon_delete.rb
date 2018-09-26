class Cli::TrainWagonDelete < Cli::BaseCommands
  def info
    super 'Убрать вагон'
  end

  protected

  attr_reader :train, :wagons

  def params_valid?
    self.train = session.get_current_object
    self.wagons = train.wagons
    if wagons.empty?
      info_message "Нужно добавить поезду \"#{train}\" вагоны"
      return false
    end
    true
  end

  def command
    Cli::WagonList.new.show_table(wagons)
    print "\n№ вагона: "
    id = gets.to_i
    wagon = wagons[id]
    train.uncoupling_wagons([wagon])
    delete_wagon if valid?(wagon)
  end

  private

  attr_writer :train, :wagons

  def valid?(wagon)
    if wagon.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    train.valid?
  end

  def delete_wagon
    train.update
    result_message "Мы отцепили от поезда \"#{train}\" вагон\n"
  end
end

