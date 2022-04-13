require_relative "statement/parser"

require_relative "statement/modifier" # a { b } unless  c { d }
require_relative "statement/block" # a or b { c or d }
require_relative "statement/and" # not a or not b
require_relative "statement/not" # b = not a
require_relative "statement/assign" # a = b rescue c
require_relative "statement/rescue" # a ? b : c rescue d
require_relative "statement/ternary" # a ? b..c : c..d
require_relative "statement/range" # a..b || c..d
require_relative "statement/multiplication"
require_relative "statement/plus"
require_relative "statement/call" # 1.times { 1 }
require_relative "statement/value" # 1

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
