require 'singleton'

module System
  class Session
    include Singleton

    def set_current_object(object, label = '')
      @object = object
      @object_label = label.capitalize
    end

    def get_current_object
      keeper.find(@object.class.collection_name, @object.saved_key)
    end

    def clear_current_object
      @object = nil
    end

    def current_object_info
      [@object, @object_label]
    end

    private

    def keeper
      System::Keeper.instance
    end
  end
end

