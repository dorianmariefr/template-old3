require_relative "value/parser"

class Template
  class Value < Node
    NOTHING = :nothing
    BOOLEAN = :boolean
    STRING = :string
    NUMBER = :number
    LIST = :list
    DICTIONNARY = :dictionnary
    CALL = :call

    def initialize(parsed)
      parsed = parsed.dup
      @nothing = parsed.delete(NOTHING)
      @nothing = ::Template::Nothing.new(nothing) if nothing?
      @boolean = parsed.delete(BOOLEAN)
      @boolean = ::Template::Boolean.new(boolean) if boolean?
      @string = parsed.delete(STRING)
      @string = ::Template::String.new(string) if string?
      @number = parsed.delete(NUMBER)
      @number = ::Template::Number.new(number) if number?
      @list = parsed.delete(LIST)
      @list = ::Template::List.new(list) if list?
      @dictionnary = parsed.delete(DICTIONNARY)
      @dictionnary = ::Template::Dictionnary.new(dictionnary) if dictionnary?
      @call = parsed.delete(CALL)
      @call = ::Template::Call.new(call) if call?
      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless value?
    end

    def self.key
      :value
    end

    def self.parser
      ::Template::Value::Parser
    end

    def evaluate(context = default_context)
      value.evaluate(context)
    end

    def render(context = default_context)
      evaluate(context).render
    end

    private

    attr_reader :nothing, :boolean, :string, :number, :list, :dictionnary, :call

    def value?
      nothing? || boolean? || string? || number? || list? || dictionnary? ||
        call?
    end

    def nothing?
      !!nothing
    end

    def boolean?
      !!boolean
    end

    def string?
      !!string
    end

    def number?
      !!number
    end

    def list?
      !!list
    end

    def dictionnary?
      !!dictionnary
    end

    def call?
      !!call
    end

    def value
      nothing || boolean || string || number || list || dictionnary || call ||
        raise(NotImplementedError)
    end
  end
end
