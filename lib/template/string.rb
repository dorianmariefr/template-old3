require_relative "string/parser"

class Template
  class String < Node
    def initialize(parsed)
      @value = parsed
      raise parsed.inspect unless string?
    end

    def self.key
      :string
    end

    def self.parser
      ::Template::String::Parser
    end

    def fetch(*args)
      ::Template::Nothing.nothing
    end

    def evaluate(_context = default_context)
      self
    end

    def render(_context = default_context)
      value
    end

    def equal?(other)
      other == value
    end

    private

    attr_reader :value

    def string?
      value.is_a?(::Parslet::Slice) || value.is_a?(::String)
    end
  end
end
