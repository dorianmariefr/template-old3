require_relative "string/parser"

class Template
  class String
    def initialize(parsed)
      @value = parsed
      raise parsed.inspect unless string?
    end

    def fetch(*args)
      ::Template::Nothing.nothing
    end

    def evaluate(_context = ::Template::Dictionnary.empty)
      self
    end

    def render(_context = ::Template::Dictionnary.empty)
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
