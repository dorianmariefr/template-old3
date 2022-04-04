require_relative "value/parser"

class Template
  class Value
    NOTHING = :nothing
    BOOLEAN = :boolean
    STRING = :string
    NUMBER = :number
    LIST = :list
    DICTIONNARY = :dictionnary

    def initialize(parsed)
      parsed = parsed.dup
      @nothing = parsed.delete(NOTHING)
      @boolean = parsed.delete(BOOLEAN)
      @string = parsed.delete(STRING)
      @number = parsed.delete(NUMBER)
      @list = parsed.delete(LIST)
      @dictionnary = parsed.delete(DICTIONNARY)
      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless value?
    end

    def evaluate
      if nothing?
        ::Template::Nothing.new(nothing)
      elsif boolean?
        ::Template::Boolean.new(boolean)
      elsif string?
        ::Template::String.new(string)
      elsif number?
        ::Template::Number.new(number)
      elsif list?
        ::Template::List.new(list)
      elsif dictionnary?
        ::Template::Dictionnary.new(dictionnary)
      else
        raise NotImplementedError
      end
    end

    def render
      evaluate.render
    end

    private

    attr_reader :nothing, :boolean, :string, :number, :list, :dictionnary

    def value?
      nothing? || boolean? || string? || number? || list? || dictionnary?
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
  end
end
