module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@instance_counts, 0)
  end

  module ClassMethods
    def instances
      class_variable_get(:@@instance_counts)
    end
  end

  module InstanceMethods

    protected

    def register_instance
      counts = self.class.class_variable_get(:@@instance_counts)
      self.class.class_variable_set(:@@instance_counts, counts + 1)
    end
  end
end

