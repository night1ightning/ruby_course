class Model::PassengerTrain < Model::Train
  def initialize(number)
    super(:passenger, number)
  end

  def self.collection_name
    :passenger_train
  end

  def valid!
    super
    return if wagons.empty?
    wagons.each do |wagon|
      unless wagon.is_a? Model::PassengerWagon
        raise Err::InvalidModelAttributes.new model: 'PassengerTrain', 
          arg: 'wagons', msg: 'В список пассажирских вагонов'\
          ' был добавлен посторонний объект '
      end
    end
    if wagons != wagons.uniq
      raise Err::InvalidModelAttributes.new model: 'PassengerTrain',
        arg: 'wagons', msg: 'Каждый вагон уникален имеет номер,'\
        ' нельзя клонировать вагоны'
    end
  end
end

