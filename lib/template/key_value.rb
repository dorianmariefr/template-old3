class Template
  class KeyValue
    def initialize(parsed)
      parsed = parsed.dup

      @key = ::Template::Value.new(parsed.delete(:key))
      @value = ::Template::Value.new(parsed.delete(:value))

      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless key_value?
    end

    def evaluate
      @key = key.evaluate
      @value = value.evaluate
      self
    end

    def render
      "#{key.render}: #{value.render}"
    end

    private

    attr_reader :key, :value

    def key_value?
      key? && value?
    end

    def key?
      !!key
    end

    def value?
      !!value
    end
  end
end
