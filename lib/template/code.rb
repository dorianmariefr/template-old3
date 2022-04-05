require_relative "code/parser"

class Template
  class Code < Node
    def initialize(parsed)
      @statements = parsed.map do |statement|
        ::Template::Statement.new(statement)
      end

      raise parsed.inspect unless code?
    end

    def self.key
      :code
    end

    def self.parser
      ::Template::Code::Parser
    end

    def evaluate(context = default_context)
      statements.map { |child| child.evaluate(context) }.last
    end

    def render(context = default_context)
      evaluate(context).render
    end

    private

    attr_reader :statements

    def code?
      statements.is_a?(::Array)
    end
  end
end
