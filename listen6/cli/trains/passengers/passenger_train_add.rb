class Cli::PassengerTrainAdd < Cli::BaseCommands
  def info
    super 'Добавить пассажирский поезд'
  end

  protected

  attr_reader :passenger_train

  def command
    print "\nНомер поезда: "
    number = gets.to_i
    self.passenger_train = Model::PassengerTrain.new(number)
    create if valid?
  end

  private

  attr_writer :passenger_train

  def valid?
    passenger_train.valid?
  end

  def create
    passenger_train.create
    result_message "Пассажирский поезд \"#{passenger_train}\" успешно добавлен\n"
  end
end

