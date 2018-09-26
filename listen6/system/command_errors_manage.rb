class CommandErrorsManage
  include Singleton
  include Modules::Info

  def initialize
    @errors = []
  end

  def add_msg(msg)
    errors << msg
  end

  def current_errors
    errors.each { |error| error_message error }
  end

  def errors?
    !errors.empty?
  end

  def next_command
    # Здесь можно логировать старые ошибки
    @errors = []
  end

  private

  attr_accessor :errors
end

