require_relative 'base_train.rb'

class CargoTrain < BaseTrain
  def initialize(number)
    super(:cargo, number)
  end
end

