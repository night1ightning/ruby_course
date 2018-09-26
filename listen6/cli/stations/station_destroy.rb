class Cli::StationDestroy < Cli::BaseCommands
  def info
    super 'Удалить станцию'
  end

  protected

  attr_reader :stations, :station

  def params_valid?
    self.stations = Model::Station.list
    if stations.empty?
      info_message "\nСписок станций пуст"
      return false
    end
    true
  end

  def command
    Cli::StationList.new.show_table(stations)
    print "\n№ станции: "
    id = gets.to_i
    self.station = stations[id]
    destroy if valid?
  end

  private 
   
  attr_writer :stations, :station

  def valid?
    if station.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    station.valid?
  end

  def destroy
    Model::Station.destroy(station)
    result_message "Станция \"#{station}\" удалена"
  end
end

