# typed: strict
require_relative "nothing/parser"

class Template
  class Nothing
    extend T::Sig
    sig { params(parsed: ::String).void }
    def initialize(parsed)
      @value = T.let(parsed, ::String)
    end

    sig { params(object: ::NilClass).returns(::Template::Nothing) }
    def self.from_ruby(object)
      new("nothing")
    end

    sig { returns(::NilClass) }
    def to_ruby
      nil
    end

    sig { returns(::Template::Nothing) }
    def evaluate
      self
    end

    sig { returns(::String) }
    def render
      ""
    end

    private

    sig { returns(::String) }
    attr_reader :value
  end
end
