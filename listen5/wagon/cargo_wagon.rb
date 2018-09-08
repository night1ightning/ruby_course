class Model::CargoWagon < Model::BaseWagon
  attr_reader :current_weight, :maximum_weight

  def initialize(maximum_weight)
    @maximum_weight = maximum_weight
    @current_weight = 0
  end

  def current_weight=(current_weight)
    if current_weigth.negative? || @maximum_weight < current_weight
      @current_weight = current_weight 
    end
  end

  def type
    :cargo
  end
end

