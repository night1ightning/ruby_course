class Model::CargoWagon < Model::Wagon
  attr_reader :current_weight, :maximum_weight

  def initialize(maximum_weight)
    @maximum_weight = maximum_weight
    @current_weight = 0
  end

  def to_s
    sprintf("%20s | № %s", 'Грузовой вагон', object_id)
  end

  def self.collection_name
    :cargo_wagon
  end

  def current_weight=(current_weight)
    if current_weigth.negative? || @maximum_weight < current_weight
      @current_weight = current_weight 
    end
  end

  def type
    :cargo
  end

  def valid!
    if maximum_weight < 1
      raise Err::InvalidModelAttributes.new model: 'CargoWagon', 
        arg: 'maximum_weigh', msg: 'Максимальный вес не может быть 0 или отрицательным'
    end
  end
end

