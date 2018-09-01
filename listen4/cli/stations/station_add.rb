class Cli::StationAdd < Cli::BaseCommands
  def info
    super 'Добавить новую станцию'
  end

  protected

  attr_reader :stations

  def command
    self.stations = keeper.get_collection_by_type(:station)
    Cli::StationList.new.show_table(stations)
    print "\nНазвание станции: "
    name = gets.chomp
    save(name) if valid?(name)
  end

  private 

  attr_writer :stations

  def valid?(name)
    stationsSameName = stations.select { |station| station.name == name }
    unless stationsSameName.empty?
      error_message "\nСтанция с таким название уже существует"
      return false
    end
    true
  end

  def save(name)
    station = Model::Station.new(name)
    stations = self.stations << station
    keeper.set_collection_by_type(:station, stations)
    result_message "Станция \"#{station}\" успешно добавлена\n"
  end
end

