class Model::CargoTrain < Model::Train
  def initialize(number)
    super(:cargo, number)
  end

  def self.collection_name
    :cargo_train
  end

  def valid!
    super
    return if wagons.empty?
    wagons.each do |wagon|
      unless wagon.is_a? Model::CargoWagon
        raise Err::InvalidModelAttributes.new model: 'CargoTrain', 
          arg: 'wagons', msg: 'В список грузовых вагонов был'\
          ' добавлен посторонний объект '
      end
    end
    if wagons != wagons.uniq
      raise Err::InvalidModelAttributes.new model: 'CargoTrain', 
        arg: 'wagons', msg: 'Каждый вагон уникален,'\
        ' у него есть номер, нет одинаковых вагонов'
    end
  end
end

