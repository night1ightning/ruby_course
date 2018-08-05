class Train
  attr_accessor :number, :speed
  attr_reader :type, :number_wagons, :station

  def initialize(type, number, number_wagons = 0)
    @type = type.to_s
    @number = number.to_i
    @number_wagons = number_wagons.to_i
    @route = nil
    @future_station = []
    @past_station = []
  end

  def stop
    self.speed = 0
    nil
  end

  def add_one_wagon
    return if speed.nonzero?
    @number_wagons += 1
    nil
  end

  def uncoupling_one_wagon
    return if speed.nonzero?
    @number_wagons -= 1
    nil
  end

  def route=(route)
    return unless route.is_a? Route
    @stations = route.stations
    @station = @stations.first
    @future_station = @stations.reverse[0...-1]
    @past_station = []
    nil
  end

  def last_current_next_stations
    [@past_station[-1], @station, @next_station[-1]]
  end

  def move_next_station
    return if  @future_station.empty?
    station = @future_station.delete_at(-1)
    @past_station << @station
    @station  = station
    nil
  end

  def back_before_station
    return if  @past_station.empty?
    station = @past_station.delete_at(-1)
    @future_station << @station
    @station = station
    nil
  end
end

