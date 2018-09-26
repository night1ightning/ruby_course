class Cli::StationAdd < Cli::BaseCommands
  def info
    super 'Добавить новую станцию'
  end

  protected

  attr_reader :station

  def command
    stations = Model::Station.list
    Cli::StationList.new.show_table(stations)
    print "\nНазвание станции: "
    name = gets.chomp
    self.station = Model::Station.new(name)
    create if valid?
  end

  private 

  attr_writer :station

  def valid?
    station.valid?
  end

  def create
    station.create
    result_message "Станция \"#{station}\" успешно добавлена"
  end
end

