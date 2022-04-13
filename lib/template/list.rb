require_relative "list/parser"

class Template
  class List < Node
    def initialize(parsed)
      parsed = parsed.is_a?(::String) ? {} : parsed.dup

      @children =
        [
          parsed.delete(:first),
          parsed.delete(:second),
          parsed.delete(:others)
        ].flatten.compact.map { |value| ::Template::Value.new(value) }

      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless array?
    end

    def self.key
      :list
    end

    def self.parser
      ::Template::List::Parser
    end

    def evaluate(context = default_context)
      @children = children.map { |child| child.evaluate(context) }
      self
    end

    def render(context = default_context)
      evaluate(context)
      children.map(&:render).join(" ")
    end

    private

    attr_reader :children

    def array?
      children.is_a?(::Array)
    end
  end
end
