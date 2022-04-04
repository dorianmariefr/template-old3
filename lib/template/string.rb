require_relative "string/parser"

class Template
  class String
    def initialize(parsed)
      @value = parsed
      raise parsed.inspect unless string?
    end

    def evaluate
      self
    end

    def render
      value
    end

    private

    attr_reader :value

    def string?
      value.is_a?(::Parslet::Slice) || value.is_a?(::String)
    end
  end
end
