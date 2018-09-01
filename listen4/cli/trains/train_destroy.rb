class Cli::TrainDestroy < Cli::BaseCommands
  def info
    super 'Удалить поезд'
  end

  protected

  attr_reader :trains

  def params_valid?
    self.trains = keeper.get_collection_by_type(:train)
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
    destroy(id) if valid?(id)
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

  def destroy(id)
    train = trains.delete_at(id)
    keeper.set_collection_by_type(:train, trains)
    result_message "Поезд \"#{train}\" удален\n"
  end
end

