module MicroRedis
  class Application
    attr_reader :storage

    def initialize
      @storage = {}
    end

    def get(key) = storage[key]

    def set(key, value) = storage[key] = value

    def del(key) = storage.delete(key)

    def size = storage.size

    def exists?(key) = storage.include?(key)

    def not_exists?(key) = !exists?(key)

    def type(key) = get(key).class

    def keys = storage.keys

    def len(key)
      return get(key).size unless numeric?(key)

      raise TypeError, "expected a String, got #{type(key)}"
    end

    def incr(key)
      return set(key, get(key) + 1) if numeric?(key)

      raise TypeError, "expected a Integer, got #{type(key)}"
    end

    def decr(key)
      return set(key, get(key) - 1) if numeric?(key)

      raise TypeError, "expected a Integer, got #{type(key)}"
    end

    def incr_by(key, value)
      return set(key, get(key) + value) if numeric?(key)

      raise TypeError, "expected a Integer, got #{type(key)}"
    end

    def decr_by(key, value)
      return set(key, get(key) - value) if numeric?(key)

      raise TypeError, "expected a Integer, got #{type(key)}"
    end

    private

    def numeric?(key)
      type(key) == Integer || type(key) == Float
    end
  end
end
