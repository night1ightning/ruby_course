class Err::InvalidModelAttributes < Err::ConsoleApplication
  def initialize(model: '', arg: '', msg: '')
    super "Ошибка для модели \"#{model}\""\
          ", атрибут: \"#{arg}\" содержит ошибки.\n#{msg}."
  end
end

