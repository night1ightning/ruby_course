class Cli::PassengerWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить пассажирский вагон'
  end

  protected
  
  attr_reader :passenger_wagon

  def command
    print "\nКоличество посадочных мест: "
    number_seats = gets.to_i
    self.passenger_wagon = Model::PassengerWagon.new(number_seats)
    create if valid?
  end

  private

  attr_writer :passenger_wagon

  def valid?
    passenger_wagon.valid?
  end

  def create
    passenger_wagon.valid?
    result_message "Пассажирский вагон успешно добавлен\n"
  end
end

