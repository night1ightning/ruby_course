module System
  class Loader
    def self.set_group(group:, path:)
      object = Object.const_set(group, Module.new)
      object.module_eval do
        Dir["#{path}/**/*.rb"].each do |path| 
          class_name = System::Loader.path_to_class_name(path)
          object.autoload class_name, path
        end
      end
    end

    def self.to_root_group(path:)
      Dir["#{path}/**/*.rb"].each do |path| 
        require_relative path
      end
    end

    private 

    def self.path_to_class_name(path)
      file_name = File.basename(path, '.rb')
      System::Loader.camelize(file_name).to_sym 
    end

    def self.camelize(string)
      parts = string.split('_')
      parts.map!(&:capitalize)
      parts.join('')
    end
  end 
end

