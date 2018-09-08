require_relative 'modules/instance_counter.rb'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  def to_s
    name
  end

  def initialize(name)
    @name = name.to_s.capitalize
    @trains = []
    self.register_instance
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

