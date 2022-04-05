require_relative "statement/parser"

class Template
  class Statement < Node
    def initialize(parsed)
      @value = parsed.delete(:value)
      @value = ::Template::Value.new(value) if value
      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless statement?
    end

    def self.key
      nil
    end

    def self.parser
      ::Template::Statement::Parser
    end

    def evaluate(context = default_context)
      statement.evaluate(context)
    end

    def render(context = default_context)
      evaluate(context).render
    end

    private

    attr_reader :value

    def statement
      value
    end

    def statement?
      value?
    end

    def value?
      !!value
    end
  end
end
