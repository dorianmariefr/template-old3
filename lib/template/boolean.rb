require_relative "boolean/parser"

class Template
  class Boolean
    TRUE = "true"
    FALSE = "false"

    def initialize(parsed)
      @value = parsed
      raise parsed.inspect unless boolean?
    end

    def evaluate
      self
    end

    def render
      value
    end

    private

    attr_reader :value

    def true?
      value == TRUE
    end

    def false?
      value == FALSE
    end

    def boolean?
      true? || false?
    end
  end
end
