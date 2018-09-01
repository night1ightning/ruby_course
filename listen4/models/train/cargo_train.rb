class Model::CargoTrain < Model::BaseTrain
  def initialize(number)
    super(:cargo, number)
  end
end

