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
    return if speed.nonzero?
    @number_wagons += 1
  end

  def uncoupling_one_wagon
    return if speed.nonzero? || @number_wagons.zero?
    @number_wagons -= 1
  end

  def route=(route)
    return unless route.is_a? Route
    @stations = route.stations
    @index_current = 0
    current_station.take_train(self)
  end

  def previous_station
    return if @stations.nil? || @index_current.zero?
    index_previous = @index_current - 1
    @stations[index_previous]
  end

  def current_station
    return if @stations.nil?
    @stations[@index_current]
  end

  def next_station
    return if @stations.nil?
    index_next = @index_current + 1
    @stations[index_next]
  end

  def move_next_station
    change_station(train, 1) if next_station
  end

  def back_before_station
    change_station(train, -1) if previous_station
  end

  private

  def change_station(step)
    station = @stations[@index_current]
    station.take_out(self)
    @index_current += step
    station = @stations[@index_current]
    station.take_train(self)
  end
end

