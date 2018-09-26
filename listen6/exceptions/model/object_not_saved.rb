class Err::ObjectNotSaved < Err::ConsoleApplication
  def initialize(object:)
    super "Попытка обновить не созданный объект #{object.inspect}"
  end
end

