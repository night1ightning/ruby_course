require_relative 'base_train.rb'

class PassengerTrain < BaseTrain
  def initialize(number)
    super(:passenger, number)
  end
end

