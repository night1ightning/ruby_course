class Cli::PassengerWagonAdd < Cli::BaseCommands
  def info
    super 'Добавить пассажирский вагон'
  end

  protected
  
  def command
    print "\nКоличество посадочных мест: "
    number_seats = gets.to_i
    save(number_seats) if valid?(number_seats)
  end

  private

  def valid?(number_seats)
    if number_seats < 1
      error_message "\nКоличество посадочных мест"\
        "не может быть 0 или отрицательным"
      return false
    end
    true
  end

  def save(number_seats)
    passenger_wagon = Model::PassengerWagon.new(number_seats)
    wagons = keeper.get_collection_by_type(:wagon)
    wagons << passenger_wagon
    keeper.set_collection_by_type(:wagon, wagons)
    result_message "Пассажирский вагон успешно добавлен\n"
  end
end

