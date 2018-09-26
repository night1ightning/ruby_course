class Cli::CargoTrainAdd < Cli::BaseCommands
  def info
    super 'Добавить грузовой поезд'
  end

  protected

  attr_reader :cargo_train

  def command
    print "\nНомер поезда: "
    number = gets.chomp
    self.cargo_train = Model::CargoTrain.new(number)
    create if valid?
  end

  private

  attr_writer :cargo_train

  def valid?
    cargo_train.valid?
  end

  def create
    cargo_train.create
    result_message "Грузовой поезд \"#{cargo_train}\" успешно добавлен\n"
  end
end

