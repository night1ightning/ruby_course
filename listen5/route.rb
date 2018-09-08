require_relative 'modules/instance_counter.rb'

class Route
  include InstanceCounter
  attr_reader :stations, :name

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
    self.register_instance
  end

  def to_s
    name
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

  def print_stations
    list = stations.map { |station| station.name }.join(',')
    puts "Stations: #{list}"
  end
end

