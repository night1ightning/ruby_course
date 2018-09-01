class Cli::WagonDestroy < Cli::BaseCommands
  def info
    super 'Удалить вагон'
  end

  protected

  attr_reader :wagons

  def params_valid?
    self.wagons = keeper.get_collection_by_type(:wagon)
    if wagons.empty?
      info_message "\nСписок вагонов пуст"
      return false
    end
    true
  end

  def command
    Cli::TrainList.new.show_table(wagons)
    print "\n№ вагона: "
    id = gets.to_i
    destroy(id) if valid?(id)
  end

  private 
   
  attr_writer :wagons

  def valid?(id)
    if wagons[id]
      return true
    end
    error_message "\n№ не верен"
    false
  end

  def destroy(id)
    wagon = wagons.delete_at(id)
    keeper.set_collection_by_type(:wagon, wagons)
    result_message "Вагон удален\n"
  end
end

