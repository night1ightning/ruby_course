require 'singleton'

module System
  class Keeper
    include Singleton

    def initialize
      @collection = Hash.new{ |hsh, key| hsh[key] = {} }
      @index = 0
    end

    def list(key)
      collection = @collection[key].values
      return [] if collection.empty?
      collection.map do |original|
        get_clone(original)
      end
    end

    def find(key, saved_key)
      original = @collection[key].values.detect do |object|
        object.saved_key == saved_key
      end
      get_clone(original)
    end

    def save_list(key, collection)
      collection.each do |object|
        object.create
      end
    end

    def create(key, object)
      object.valid!
      @collection[key][@index] = object
      object.saved_key = @index
      new_object = get_clone(object)
      @index += 1
      new_object
    end

    def update(key, object)
      validate_exist!(key, object)
      index = object&.saved_key
      @collection[key][index] = object
      object
    end

    def destroy(key, object)
      validate_exist!(key, object)
      index = object&.saved_key
      @collection[key].delete(index)
      object
    end

    private

    def get_clone(original)
      new_object = Marshal::load(Marshal.dump(original)) 
      new_object.parent_object_id = original.object_id
      new_object
    end

    def validate_exist!(key, object)
      unless object.is_a? Model::BaseModel
        raise Err::ObjectNotModel collection: key, object: object
      end
      index = object&.saved_key
      raise Err::ObjectNotSaved.new object: object if index.nil?
      original = @collection[key][index];
      if original.nil?
        raise Err::ObjectNotModel.new collection: key, object: object
      end
      unless object.parent_object_id == original.object_id
        raise Err::HackingAttempt.new  collection: key, 
          object: object, action: 'update'
      end
    end
  end
end

