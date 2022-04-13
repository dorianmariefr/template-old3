require_relative "dictionnary/parser"

class Template
  class Dictionnary < Node
    def initialize(parsed)
      parsed = parsed.is_a?(::String) ? {} : parsed.dup

      @children =
        [
          parsed.delete(:first),
          parsed.delete(:second),
          parsed.delete(:others)
        ].flatten.compact.map { |value| ::Template::KeyValue.new(value) }

      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless array?
    end

    def self.key
      :dictionnary
    end

    def self.parser
      ::Template::Dictionnary::Parser
    end

    def self.empty
      new({})
    end

    def fetch(*args)
      value = children.detect { |child| child.key?(args[0]) }&.value
      args.size == 2 ? value || args[1] : value || ::Template::Nothing.nothing
    end

    def evaluate(context = default_context)
      @children = children.map { |child| child.evaluate(context) }
      self
    end

    def render(context = default_context)
      evaluate(context)
      children.map { |child| child.render }.join(" ")
    end

    private

    attr_reader :children

    def array?
      children.is_a?(::Array)
    end
  end
end
