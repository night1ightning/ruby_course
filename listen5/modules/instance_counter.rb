module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instance_counts || 0
    end
  end

  module InstanceMethods

    protected

    def register_instance
      counts = self.class.instances
      self.class.instance_variable_set(:@instance_counts, counts + 1)
    end
  end
end

