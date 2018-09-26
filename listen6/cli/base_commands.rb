class Cli::BaseCommands
  include Modules::Info

  attr_reader :children, :parent, :command_number

  def info(text)
    info_message sprintf("%30s | %i", text, command_number)
  end

  def execute
    @success = true
    errors.next_command
    unless params_valid?
      @success = false
      return
    end
    command
    if errors?
      errors.current_errors 
      @success = false
    end
  end

  def command_number=(value)
    return if value.nil? || value < 1
    @command_number = value 
  end

  def children=(value)
    return if value.nil? 
    @children = value 
  end

  def parent=(value)
    return if value.nil?
    @parent = value 
  end

  def success?
    @success == true
  end

  def errors?
    errors.errors?
  end

  protected

  def params_valid? 
    true
  end

  def command ; end

  def keeper
    System::Keeper.instance
  end

  def session
    System::Session.instance
  end

  def errors
    CommandErrorsManage.instance
  end
end

