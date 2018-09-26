class Cli::TrainDestroy < Cli::BaseCommands
  def info
    super 'Удалить поезд'
  end

  protected

  attr_reader :trains, :train

  def params_valid?
    self.trains = [
      Model::CargoTrain.list, 
      Model::PassengerTrain.list
    ].flatten
    if trains.empty?
      info_message "\nСписок поездов пуст"
      return false
    end
    true
  end

  def command
    Cli::TrainList.new.show_table(trains)
    print "\nId поезда: "
    id = gets.to_i
    self.train = trains[id]
    destroy if valid?
  end

  private 
   
  attr_writer :trains, :train

  def valid?
    if train.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    train.valid? 
  end

  def destroy
    train.class.destroy(train)
    result_message "Поезд \"#{train}\" удален\n"
  end
end

