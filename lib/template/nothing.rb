require_relative "nothing/parser"

class Template
  class Nothing < Node
    NOTHING = "nothing"

    def initialize(parsed)
      @value = parsed
      raise parsed.inspect unless nothing?
    end

    def self.nothing
      new(NOTHING)
    end

    def self.key
      :nothing
    end

    def self.parser
      ::Template::Nothing::Parser
    end

    def evaluate(_context = default_context)
      self
    end

    def render(_context = default_context)
      ""
    end

    private

    attr_reader :value

    def nothing?
      value == NOTHING
    end
  end
end
