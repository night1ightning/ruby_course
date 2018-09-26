class Cli::WagonDestroy < Cli::BaseCommands
  def info
    super 'Удалить вагон'
  end

  protected

  attr_reader :wagons, :wagon

  def params_valid?
    self.wagons = [
      Model::CargoWagon.list,
      Model::PassengerWagon.list
    ].flatten
    if wagons.empty?
      info_message "\nСписок вагонов пуст"
      return false
    end
    true
  end

  def command
    Cli::WagonList.new.show_table(wagons)
    print "\n№ вагона: "
    id = gets.to_i
    self.wagon = wagons[id]
    destroy if valid?
  end

  private 
   
  attr_writer :wagons, :wagon

  def valid?
    if wagon.nil?
      errors.add_msg "\n№ не верен"
      return false
    end
    wagon.valid?
  end

  def destroy
    wagon.class.destroy(wagon)
    result_message "Вагон удален\n"
  end
end

