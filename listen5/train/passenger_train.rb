class PassengerTrain < BaseTrain
  def initialize(number)
    super(:passenger, number)
    self.register_instance
  end
end

