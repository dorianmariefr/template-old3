require_relative "key_value/parser"

class Template
  class KeyValue < Node
    attr_reader :value

    def initialize(parsed)
      parsed = parsed.dup

      @key = ::Template::Statement.new(parsed.delete(:key))
      @value = ::Template::Statement.new(parsed.delete(:value))

      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless key_value?
    end

    def self.key
      nil
    end

    def self.parser
      raise NotImplementedError
    end

    def evaluate(context = default_context)
      @key = key.evaluate(context)
      @value = value.evaluate(context)
      self
    end

    def render(context = default_context)
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
