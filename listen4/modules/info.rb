module Modules
  module Info
    def error_message(message)
      warn message.colorize(:red)
      @has_error = true
    end

    def info_message(message)
      puts message.colorize(:blue)
    end

    def result_message(message)
      puts message.colorize(:green)
    end
  end
end

