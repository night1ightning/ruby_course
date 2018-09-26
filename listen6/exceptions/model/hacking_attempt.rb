class Err::HackingAttempt < Err::ConsoleApplication
  def initialize(collection:, object:, action:)
    super "Попытка попытка доступа #{action} к чужому объектy для колекции #{collection},\n"\
          " неизвестный объект #{object.inspect}"
  end
end
