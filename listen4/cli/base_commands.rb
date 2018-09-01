class Cli::BaseCommands

  include Modules::Info

  attr_reader :children, :parent, :command_number

  def info(text)
    info_message sprintf("%30s | %i", text, command_number)
  end

  def execute
    @has_error = false
    command if params_valid?
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

  def errors?
    @has_error 
  end

  protected

  def params_valid? 
    true
  end

  def command ; end

  def keeper
    System::Keeper.instance
  end
end

