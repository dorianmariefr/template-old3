require_relative "text/parser"

class Template
  class Text < Node
    def initialize(parsed)
      @value = parsed
      raise parsed.inspect unless text?
    end

    def self.key
      :text
    end

    def self.parser
      ::Template::Text::Parser
    end

    def evaluate(_context = default_context)
      self
    end

    def render(_context = default_context)
      value
    end

    private

    attr_reader :value

    def text?
      value.is_a?(::Parslet::Slice) || value.is_a?(::String)
    end
  end
end
