class Cli::TrainSet < Cli::BaseCommands
  def initialize(current_train_type)
    @current_train_type = current_train_type
  end

  def info
    super 'Выбрать поезд'
  end

  protected

  attr_reader :trains, :current_train_type

  def params_valid?
    trains = keeper.get_collection_by_type(:train)
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
    set_train(id) if valid?(id)
  end

  private

  attr_writer :trains

  def valid?(id)
    if trains[id]
      return true
    end
    error_message "\nId не верен"
    false
  end

  def set_train(id)
    train = trains[id]
    keeper.set_current_object(train, 'Поезд')
    result_message "Поезд \"#{train}\" выбран\n"
  end
end

