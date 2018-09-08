require_relative '../modules/instance_counter.rb'

class CargoTrain < BaseTrain
  include InstanceCounter

  def initialize(number)
    super(:cargo, number)
    self.register_instance
  end
end

