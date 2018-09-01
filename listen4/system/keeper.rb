require 'singleton'

module System
  class Keeper
    include Singleton

    def initialize
      @collections = Hash.new{ |hsh, key| hsh[key] = [] }
    end

    def set_collection_by_type(key, collection)
      return unless collection.is_a? Array
      @collections[key] = collection
    end

    def get_collection_by_type(key)
      @collections[key]
    end

    def set_current_object(object, label = '')
      @object = object
      @object_label = label.capitalize
    end

    def get_current_object
      @object
    end

    def clear_current_object
      @object = nil
    end

    def current_object_info
      [@object, @object_label]
    end
  end 
end

