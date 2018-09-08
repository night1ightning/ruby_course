require_relative '../modules/instance_counter.rb'

class PassengerTrain < BaseTrain
  include InstanceCounter

  def initialize(number)
    super(:passenger, number)
    self.register_instance
  end
end

