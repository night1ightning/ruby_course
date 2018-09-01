class Cli::StationDestroy < Cli::BaseCommands
  def info
    super 'Удалить станцию'
  end

  protected

  attr_reader :stations

  def params_valid?
    self.stations = keeper.get_collection_by_type(:station)
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
    destroy(id) if valid?(id)
  end

  private 
   
  attr_writer :stations

  def valid?(id)
    if stations[id]
      return true
    end
    error_message "\n№ не верен"
    false
  end

  def destroy(id)
    station = stations.delete_at(id)
    keeper.set_collection_by_type(:station, stations)
    result_message "Станция \"#{station}\" удалена\n"
  end
end

