class Cli::CargoTrainAdd < Cli::BaseCommands
  def info
    super 'Добавить грузовой поезд'
  end

  protected

  def command
    print "\nНомер поезда: "
    number = gets.to_i
    cargo_train = Model::CargoTrain.new(number)
    save(cargo_train)
  end

  private

  def save(train)
    trains = keeper.get_collection_by_type(:train)
    trains << train
    keeper.set_collection_by_type(:train, trains)
    result_message "Грузовой поезд \"#{train}\" успешно добавлен\n"
  end
end

