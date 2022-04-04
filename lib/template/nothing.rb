require_relative "nothing/parser"

class Template
  class Nothing
    NOTHING = "nothing"

    def initialize(parsed)
      @value = parsed
      raise parsed.inspect unless nothing?
    end

    def evaluate
      self
    end

    def render
      ""
    end

    private

    attr_reader :value

    def nothing?
      value == NOTHING
    end
  end
end
