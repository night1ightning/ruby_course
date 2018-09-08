require_relative '../modules/nameable.rb'
require_relative '../train/base_train.rb'

class BaseWagon
  include Nameable
  attr_reader :train

  def train=(train)
    return unless train.is_a? BaseTrain
    @train = train
  end

  def type ; end
end

