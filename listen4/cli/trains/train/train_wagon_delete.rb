class Cli::TrainWagonDelete < Cli::BaseCommands
  def info
    super 'Убрать вагон'
  end

  protected

  attr_reader :train, :wagons

  def params_valid?
    self.train = keeper.get_current_object
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
    delete_wagon(id) if valid?(id)
  end

  private

  attr_writer :train, :wagons

  def valid?(id)
    if wagons[id]
      return true
    end
    error_message 'Вы ввели не верный id'
    false
  end

  def delete_wagon(id)
    wagon = wagons[id]
    train.uncoupling_wagons([wagon])
    result_message "Мы отцепили от поезда \"#{train}\" вагон\n"
  end
end

