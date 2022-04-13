require_relative "statement/parser"

class Template
  class Statement < Node
    def initialize(parsed)
      @value = parsed.delete(:value)
      @value = ::Template::Statement::Value.new(value) if value

      @plus = parsed.delete(:plus)
      @plus = ::Template::Statement::Plus.new(plus) if plus

      @multiplication = parsed.delete(:multiplication)

      if multiplication
        @multiplication =
          ::Template::Statement::Multiplication.new(multiplication)
      end

      @call = parsed.delete(:call)
      @call = ::Template::Statement::Call.new(call) if call

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

    attr_reader :value, :plus, :multiplication, :call

    def statement
      value || plus || multiplication || call
    end

    def statement?
      value? || plus? || multiplication? || call?
    end

    def value?
      !!value
    end

    def plus?
      !!plus
    end

    def multiplication?
      !!multiplication
    end

    def call?
      !!call
    end
  end
end
