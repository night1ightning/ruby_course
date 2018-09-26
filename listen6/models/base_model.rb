class Model::BaseModel
  extend Modules::Info

  attr_reader :saved_key
  attr_accessor :parent_object_id

  def saved_key=(saved_key)
    @saved_key ||= saved_key.freeze
  end

  def self.collection_name
    :common
  end

  def create
    keeper.create(self.class.collection_name, self)
  end

  def update
    keeper.update(self.class.collection_name, self)
  end

  def valid?
    valid! || true
  rescue Err::ConsoleApplication => e
    errors.add_msg e.message
    false
  end

  def valid! ; end

  class << self

    def destroy(object)
      station = keeper.destroy(collection_name, object)
      object
    end

    def list
      keeper.list(collection_name)
    end
  end

  protected

  def self.keeper
    System::Keeper.instance
  end

  def keeper
    System::Keeper.instance
  end

  def errors
    CommandErrorsManage.instance
  end
end

