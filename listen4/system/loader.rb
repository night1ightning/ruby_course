module System
  class Loader
    def self.set_group(group:, path:)
      object = Object.const_set(group, Module.new)
      object.module_eval do
        Dir["#{path}/**/*.rb"].each do |path| 
          file_name = File.basename(path, '.rb')
          class_name = System::Loader.camelize(file_name).to_sym 
          object.autoload class_name,  path
        end
      end
    end

    private 

    def self.camelize(string)
      parts = string.split('_')
      parts.map!(&:capitalize)
      parts.join('')
    end
  end 
end

