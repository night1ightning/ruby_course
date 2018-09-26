class Model::Station < Model::BaseModel
  attr_reader :name, :trains

  def initialize(name)
    @name = name.to_s.capitalize
    @trains = []
  end

  def to_s
    name
  end

  def self.collection_name
    :station
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

  def valid!
    if name.empty?
      raise Err::InvalidModelAttributes.new model: 'Station', 
        arg: 'name', msg: 'Название не может быть пустым'
    end
    stations = self.class.list
    stationsSameName = stations.select do |station| 
      station.name == name && station.saved_key != self.saved_key
    end
    unless stationsSameName.empty?
      raise Err::InvalidModelAttributes.new model: 'Station', 
        arg: 'name', msg: 'Наименование станций должны быть уникальными'
    end
  end
end

