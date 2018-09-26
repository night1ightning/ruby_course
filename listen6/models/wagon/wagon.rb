class Model::Wagon < Model::BaseModel
  attr_reader :train

  def train=(train)
    return unless train.is_a? Model::Train
    @train = train
  end

  def type ; end
end

