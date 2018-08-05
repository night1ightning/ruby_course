class Route

  def initialize(station_start, station_end)
    [station_start, station_end].each do |station|
      unless station.is_a? Station
        raise ArgumentError, 'Ожидался класс Station'
      end
    end

    @station_end = station_end
    @stations = [station_start]
  end

  def take_point_station(station)
    @stations << station  
    nil
  end

  def clear_point_station(station)
    @stations.delete(station)
    nil
  end

  def stations
    [*@stations, @station_end]
  end
end

