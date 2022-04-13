require_relative "template/parser"

class Template
  class Template < Node
    def initialize(parsed)
      @children = parsed.map { |child| ::Template::Part.new(child) }

      raise parsed.inspect unless template?
    end

    def self.key
      :template
    end

    def self.parser
      ::Template::Template::Parser
    end

    def evaluate(context = default_context)
      @children = children.map { |child| child.evaluate(context) }
      self
    end

    def render(context = default_context)
      evaluate(context)
      children.map(&:render).join
    end

    private

    attr_reader :children

    def template?
      children.is_a?(::Array)
    end
  end
end
