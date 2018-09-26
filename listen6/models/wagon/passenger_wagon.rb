class Model::PassengerWagon < Model::Wagon
  attr_reader :peopls, :number_seats

  def initialize(number_seats)
    @number_seats = number_seats
    @peopls = 0
  end

  def to_s
    sprintf("%20s | № %s", 'Пассажирский вагон', object_id)
  end

  def self.collection_name
    :passenger_wagon
  end

  def peopls=(number)
    @peopls = number unless number.negative?
  end

  def type
    :passenger
  end

  def valid!
    if number_seats < 1
      raise Err::InvalidModelAttributes.new model: 'PassengerWagon', 
        arg: 'number_seats', msg: "Количество посадочных мест\n"\
        "не может быть 0 или отрицательным"
    end
  end
end

