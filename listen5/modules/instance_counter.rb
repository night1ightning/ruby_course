module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.instance_variable_set(:@instance_counts, 0)
  end

  module ClassMethods

    def instances
      instance_variable_get(:@instance_counts)
    end
  end

  module InstanceMethods

    protected

    def register_instance
      counts = self.class.instance_variable_get(:@instance_counts)
      self.class.instance_variable_set(:@instance_counts, counts + 1)
    end
  end
end

