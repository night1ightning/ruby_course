class Route
  attr_reader :stations

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
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

  def print_stations
    puts "Stations: #{@stations.join(', ')}."
  end
end

