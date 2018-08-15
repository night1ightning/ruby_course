class Train
  attr_reader :type, :number, :number_wagons

  def initialize(type, number, number_wagons = 0)
    @type = type
    @number = number
    @number_wagons = number_wagons
  end

  def acceleration(change_value)
    @speed += change_value
  end

  def deceleration(change_value)
    return if @speed.zero?
    @speed = change_value > @speed ? 0 : @speed - change_value
  end

  def add_one_wagon
    @number_wagons += 1 if speed.zero?
  end

  def uncoupling_one_wagon
    return if speed.nonzero? || @number_wagons.zero?
    @number_wagons -= 1
  end

  def set_route(route)
    return unless route.is_a? Route
    @route = route
    @index_current = 0
    current_station.take_train(self)
  end

  def previous_station
    return if @route.nil? || @index_current.zero?
    index_previous = @index_current - 1
    @route.stations[index_previous]
  end

  def current_station
    @route.stations[@index_current] if @route
  end

  def next_station
    return if @route.nil?
    index_next = @index_current + 1
    @route.stations[index_next]
  end

  def move_next_station
    return unless next_station
    current_station.take_out(self)
    next_station.take_train(self)
    @index_current += 1
  end

  def back_before_station
    return unless  previous_station
    current_station.take_out(self)
    previous_station.take_train(self)
    @index_current -= 1
  end
end

