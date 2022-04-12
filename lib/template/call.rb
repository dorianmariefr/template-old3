require_relative "call/parser"

class Template
  class Call < Node
    def initialize(parsed)
      parsed = parsed.dup
      @name = parsed.delete(:name)
      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless call?
    end

    def self.key
      :call
    end

    def self.parser
      ::Template::Call::Parser
    end

    def evaluate(context = default_context)
      context.fetch(name, ::Template::Nothing.nothing)
    end

    def render(context = default_context)
      evaluate(context).render
    end

    private

    attr_reader :name

    def call?
      name?
    end

    def name?
      !!name
    end
  end
end
