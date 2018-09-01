class Cli::TrainPreviousStation < Cli::BaseCommands
  def info
    super 'К предыдущей станции'
  end

  protected

  attr_reader :train

  def params_valid?
    self.train = keeper.get_current_object
    if train.route.nil?
      info_message "\nНужно назначить маршрут следования"
      return false
    end
    if train.previous_station
      return true
    end
    info_message "\nВы находитесь на станции отправления"
    false
  end

  def command
    back_before_station
  end

  private

  attr_writer :train

  def back_before_station
    train.back_before_station
    result_message "Поезд \"#{train}\" возратился на станцию "\
      "\"#{train.current_station}\"\n"
  end
end

