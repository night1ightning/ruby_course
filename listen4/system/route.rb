module System
  class Route
    include Modules::Info

    def initialize
      @history = [:root]
      @commands = []
      @keeper = System::Keeper.instance
    end
   
    def register(cli:, parent: :root, children: nil)
      # при запуске, порождает запуск другой ветви
      cli.children  = children 
      # идентификатор ветки где находится объект
      cli.parent  = parent 
      @commands << cli
      # номер для команды в консоле
      command_number = commands_by_level(parent).size
      cli.command_number = command_number
    end

    def observe
      if @commands.empty?
        puts 'Установите список команд.'
        return
      end
      console_info
      loop do
        code = gets.chomp
        # Красивый символ для возращения
        if code  == '<'
          back
          console_info
          next
        end
        # Ищем команду под номером
        number = code.to_i
        cli = find_command(number)
        if cli
          cli.execute
          unless cli.errors?
            to_children(cli) 
          end
          console_info
          next
        end
        # Ненашли, тогда выходим
        break
      end
    end

    private
    
    attr_reader :keeper

    def console_info
      puts '-'*60
      show_selected_object
      commands = commands_by_level(current_level)
      if commands&.first&.parent == :root  
        puts  'Это консольный менеджер железнодорожных сообщений.'
        print  "Для выполнения действия введите код.\n\n"
      end
      commands.each do |cli|
        cli.info
      end
      unless commands&.first&.parent == :root  
        puts sprintf("%30s | %s", 'Вернутся назад', '<')
      end
      puts  sprintf("%30s | %s", 'Иначе выход', '*')
      print sprintf("%30s | ", 'Код: ')
    end

    def show_selected_object
      object, label = keeper.current_object_info
      unless object.nil?
        puts sprintf("%30s :", "Выбран #{label} #{object}")
        puts ""
      end
    end

    def to_children(cli)
      return if cli.children.nil?
      @history << cli.children
    end

    def find_command(number)
      commands_by_level(current_level).detect do |cli| 
        cli.command_number == number 
      end
    end

    def commands_by_level(level)
      @commands.select { |cli| cli.parent == level } 
    end

    def current_level
      @history.last
    end

    def back
      return if @history.size < 2
      keeper.clear_current_object
      @history.delete_at(-1)
    end
  end
end

