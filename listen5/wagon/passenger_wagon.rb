class Model::PassengerWagon < Model::BaseWagon
  attr_reader :peopls, :number_seats

  def initialize(number_seats)
    @number_seats = number_seats
    @peopls = 0
  end

  def peopls=(number)
    @peopls = number unless number.negative?
  end

  def type
    :passenger
  end
end

