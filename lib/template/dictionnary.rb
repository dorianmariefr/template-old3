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

    def self.empty
      new({})
    end

    def fetch(*args)
      raise NotImplementedError if args.size < 1 || args.size > 2
      value = children.detect { |child| child.key?(args[0]) }&.value
      if args.size == 2
        value || args[1]
      else
        value || ::Template::Nothing.nothing
      end
    end

    def evaluate(context = ::Template::Dictionnary.empty)
      @children = children.map { |child| child.evaluate(context) }
      self
    end

    def render(context = ::Template::Dictionnary.empty)
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
