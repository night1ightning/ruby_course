class Model::BaseWagon

  attr_reader :train

  def train=(train)
    return unless train.is_a? Model::BaseTrain
    @train = train
  end

  def type ; end
end

