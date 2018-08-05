class Station
  attr_accessor :name

  def initialize(name)
    @name = name.to_s
    @trains = Hash.new{|hsh, key| hsh[key] = [] }
  end

  def to_s
    @name
  end

  def trains
    @trains.values.compact
  end

  def trains_by_type(type)
    @trains[type]
  end

  def take_train(train)
    return nil unless  train.is_a? Train
    @trains[train.type] << train.type
    nil
  end

  def take_out(train_name)
    @trains[type].delete(train_name)
    nil
  end
end

