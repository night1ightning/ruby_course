class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name.to_s
    @trains = []
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

