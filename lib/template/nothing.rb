require_relative "nothing/parser"

class Template
  class Nothing
    def initialize(parsed)
      @value = parsed
    end

    def self.from_ruby(_object)
      new("nothing")
    end

    def to_ruby
      nil
    end

    def evaluate
      self
    end

    def render
      ""
    end
  end
end
