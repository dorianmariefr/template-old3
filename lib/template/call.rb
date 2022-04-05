require_relative "call/parser"

class Template
  class Call
    def initialize(parsed)
      parsed = parsed.dup
      @name = parsed.delete(:name)
      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless call?
    end

    def evaluate(context = ::Template::Dictionnary.empty)
      context.fetch(name, ::Template::Nothing.nothing)
    end

    def render(context = ::Template::Dictionnary.empty)
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
