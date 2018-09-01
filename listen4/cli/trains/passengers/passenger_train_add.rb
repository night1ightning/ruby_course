class Cli::PassengerTrainAdd < Cli::BaseCommands
  def info
    super 'Добавить пассажирский поезд'
  end

  protected

  def command
    print "\nНомер поезда: "
    number = gets.to_i
    passenger_train = Model::PassengerTrain.new(number)
    save(passenger_train)
  end

  private

  def save(train)
    trains = keeper.get_collection_by_type(:train)
    trains << train
    keeper.set_collection_by_type(:train, trains)
    result_message "Пассажирский поезд \"#{train}\" успешно добавлен\n"
  end
end

