require_relative "dictionnary/parser"

class Template
  class Dictionnary
    def initialize(parsed)
      parsed = parsed.is_a?(::String) ? {} : parsed.dup

      @children = [
        parsed.delete(:first),
        parsed.delete(:second),
        parsed.delete(:others)
      ].flatten.compact.map do |value|
        Template::KeyValue.new(value)
      end

      raise parsed.inspect if parsed.any?
      raise parsed.inspect unless array?
    end

    def evaluate
      children.map(&:evaluate)
    end

    def render
      evaluate.map(&:render).join(" ")
    end

    private

    attr_reader :children

    def array?
      children.is_a?(::Array)
    end
  end
end
