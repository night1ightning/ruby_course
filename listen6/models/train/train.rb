class Model::Train < Model::BaseModel
  attr_reader :type, :number, :wagons, :route
  NUMBER_FORMAT = /\A[[:alnum:]]{3}-?[[:alnum:]]{2}\z/i

  def initialize(type, number)
    @type = type
    @number = number
    @wagons = []
  end

  def to_s
    "Поезд #{number}(#{type})"
  end

  def acceleration(change_value)
    @speed += change_value
  end

  def deceleration(change_value)
    return if @speed.zero?
    @speed = change_value > @speed ? 0 : @speed - change_value
  end

  def add_wagons(wagons)
    wagons.each do |wagon| 
      wagon.train = self
      @wagons.push(wagon) if wagon.type == @type
    end
  end

  def uncoupling_wagons(wagons)
    wagons.each do |wagon|
      wagon = @wagons.delete(wagon)
      wagon.train = nil if wagon
    end
  end

  def set_route(route)
    return unless route.is_a? Model::Route
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

  def valid!
    unless number =~ NUMBER_FORMAT
      raise Err::InvalidModelAttributes.new model: self.class.to_s, 
        arg: 'number', msg: 'Имеет не верный формат данных'
    end
  end
end

