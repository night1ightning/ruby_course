class Route
  attr_reader :stations

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
  end

  def take_point_station(station)
    @stations.insert(-2, station)
  end

  def clear_point_station(station)
    @stations.delete(station)
  end

  def print_stations
    puts "Stations: #{@stations.join(', ')}."
  end
end

