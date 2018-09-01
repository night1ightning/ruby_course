class Model::PassengerTrain < Model::BaseTrain
  def initialize(number)
    super(:passenger, number)
  end
end

