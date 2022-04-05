require_relative "part/parser"

class Template
  class Part < Node
    def initialize(parsed)
      parsed = parsed.dup
      @text = parsed.delete(:text)
      @text = ::Template::Text.new(text) if text
      @code = parsed.delete(:code)
      @code = ::Template::Code.new(code) if code
      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless part?
    end

    def self.key
      nil
    end

    def self.parser
      ::Template::Part::Parser
    end

    def evaluate(context = default_context)
      part.evaluate(context)
    end

    def render(context = default_context)
      evaluate(context).render
    end

    private

    attr_reader :text, :code

    def part?
      text? || code?
    end

    def text?
      !!text
    end

    def code?
      !!code
    end

    def part
      text || code || raise(NotImplementedError)
    end
  end
end
