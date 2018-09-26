class Model::Route < Model::BaseModel
  attr_reader :stations, :name

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
  end

  def to_s
    name
  end

  def self.collection_name
    :route
  end

  def name
    "#{stations[0].to_s.capitalize}-#{stations[-1]}"
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def take_point_station(station)
    @stations.insert(-2, station)
  end

  def clear_point_station(station)
    return if [first_station, last_station].include? station
    @stations.delete_if do |point|
      point == station
    end
  end

  def valid!
    unless stations[0] 
      raise Err::InvalidModelAttributes.new model: 'Route', 
        arg: 'station_start', msg: 'Не выбрана станция отправления'
    end
    if stations.size < 2
      raise Err::InvalidModelAttributes.new model: 'Route', 
        arg: 'station_end', msg: 'Не выбрана конечная станция'
    end
    stations.each do |station|
      unless station.is_a? Model::Station
        raise Err::InvalidModelAttributes.new model: 'Route', 
          arg: 'stations', msg: 'Вы пытаетесь добавить '\
            'неизвестный объект в список станций'
      end
    end
    if stations != stations.uniq
      raise Err::InvalidModelAttributes.new model: 'Route', 
        arg: 'stations', msg: 'Станции в маршруте не должны повторятся'
    end
  end
end

