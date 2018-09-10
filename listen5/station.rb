require_relative 'modules/instance_counter.rb'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @stations = []

  class << self
    attr_accessor :stations
  end

  def self.all
    stations
  end

  def to_s
    name
  end

  def initialize(name)
    @name = name.to_s.capitalize
    @trains = []
    self.class.stations << self
    register_instance
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def take_train(train)
    @trains << train
  end

  def take_out(train)
    @trains.delete(train) 
  end
end

