class Cli::TrainNextStation < Cli::BaseCommands
  def info
    super 'К следующей станции'
  end

  protected

  attr_reader :train

  def params_valid?
    self.train = keeper.get_current_object
    if train.route.nil?
      info_message "\nНужно назначить маршрут следования"
      return false
    end
    if train.next_station
      return true
    end
    info_message "\nВы находитесь на конечной станции"
    false
  end

  def command
    move_next_station
  end

  private

  attr_writer :train

  def move_next_station
    train.move_next_station
    result_message "Поезд \"#{train}\""\
      "прибыл на станцию \"#{train.current_station}\"\n"
  end
end

