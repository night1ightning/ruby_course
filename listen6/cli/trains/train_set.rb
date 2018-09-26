class Cli::TrainSet < Cli::BaseCommands
  def initialize(current_train_type)
    @current_train_type = current_train_type
  end

  def info
    super 'Выбрать поезд'
  end

  protected

  attr_reader :trains, :current_train_type, :train

  def params_valid?
    self.trains = [
      Model::CargoTrain.list, 
      Model::PassengerTrain.list
    ].flatten
    self.trains = trains.select { |train| train.type == current_train_type }
    if trains.empty?
      info_message "\nНужно иметь поезда"
      return false
    end
    true
  end

  def command
    Cli::TrainList.new.show_table(trains)
    print "\nId поезда: "
    id = gets.to_i
    self.train = trains[id]
    set_train if valid?
  end

  private

  attr_writer :trains, :train

  def valid?
    return true if train
    errors.add_msg "\n№ не верен"
    false
  end

  def set_train
    session.set_current_object(train, 'Поезд')
    result_message "Поезд \"#{train}\" выбран\n"
  end
end

