class Err::ObjectNotModel < Err::ConsoleApplication
  def initialize(collection:, object:)
    super "Неизвестный объект #{object.inspect}, для колекции \"#{collection}\""
  end
end

