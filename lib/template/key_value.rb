class Template
  class KeyValue
    attr_reader :value

    def initialize(parsed)
      parsed = parsed.dup

      @key = ::Template::Value.new(parsed.delete(:key))
      @value = ::Template::Value.new(parsed.delete(:value))

      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless key_value?
    end

    def evaluate(context = ::Template::Dictionnary.empty)
      @key = key.evaluate(context)
      @value = value.evaluate(context)
      self
    end

    def render(context = ::Template::Dictionnary.empty)
      "#{key.render(context)}: #{value.render(context)}"
    end

    def key?(other_key)
      key.equal?(other_key)
    end

    private

    attr_reader :key

    def key_value?
      has_key? && has_value?
    end

    def has_key?
      !!key
    end

    def has_value?
      !!value
    end
  end
end
