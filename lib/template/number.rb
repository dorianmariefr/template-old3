require_relative "number/parser"

class Template
  class Number < Node
    prepend MemoWise

    MINUS = "-"
    PLUS = "+"
    INFINITY = "Infinity"
    BASE_2 = :base_2
    BASE_8 = :base_8
    BASE_10 = :base_10
    BASE_16 = :base_16

    RUBY_SIGNS = {
      BigDecimal::SIGN_POSITIVE_FINITE => PLUS,
      BigDecimal::SIGN_NEGATIVE_FINITE => MINUS,
      BigDecimal::SIGN_POSITIVE_INFINITE => PLUS,
      BigDecimal::SIGN_NEGATIVE_INFINITE => MINUS,
      BigDecimal::SIGN_POSITIVE_ZERO => PLUS,
      BigDecimal::SIGN_NEGATIVE_ZERO => MINUS,
    }

    def initialize(parsed)
      parsed = parsed.dup
      @sign = parsed.delete(:sign)
      @infinity = parsed.delete(:infinity)
      @base_2 = parsed.delete(:base_2)
      @base_8 = parsed.delete(:base_8)
      @base_10 = parsed.delete(:base_10)
      @base_16 = parsed.delete(:base_16)
      raise parsed.inspect unless number?
      raise parsed.inspect if parsed.any?
    end

    def self.key
      :number
    end

    def self.parser
      ::Template::Number::Parser
    end

    def self.from_ruby(number)
      raise number.inspect unless number.is_a?(::BigDecimal)

      new({
        sign: RUBY_SIGNS.fetch(number.sign),
        infinity: number.infinite? ? INFINITY : nil,
        base_10: {
          whole: number.floor.to_s,
          decimal: number.modulo(1).to_s
        }
      }.compact)
    end

    def plus(other)
      ::Template::Number.from_ruby(to_ruby + other.to_ruby)
    end

    def minus(other)
      ::Template::Number.from_ruby(to_ruby - other.to_ruby)
    end

    def times(other)
      ::Template::Number.from_ruby(to_ruby * other.to_ruby)
    end

    def divided_by(other)
      ::Template::Number.from_ruby(to_ruby / other.to_ruby)
    end

    def evaluate(_context = default_context)
      self
    end

    def render(_context = default_context)
      if infinity? || to_ruby.infinite?
        to_ruby.to_s
      elsif to_ruby.to_i == to_ruby
        to_ruby.to_i.to_s
      else
        to_ruby.to_s("F")
      end
    end

    def to_ruby
      if base_2?
        ruby_sign * base_2.to_s.to_i(2).to_d
      elsif base_8?
        ruby_sign * base_8.to_s.to_i(8).to_d
      elsif base_10?
        ruby_sign * base_10_to_ruby
      elsif base_16?
        ruby_sign * base_16.to_s.to_i(16).to_d
      elsif infinity?
        ruby_sign * Float::INFINITY
      else
        raise NotImplementedError
      end
    end
    memo_wise :to_ruby

    private

    attr_reader :sign, :infinity, :base_2, :base_8, :base_10, :base_16

    def number?
      (plus? || minus?) && (infinity? || base_2? || base_8? || base_10? || base_16?)
    end

    def plus?
      sign == PLUS || sign.nil?
    end

    def minus?
      sign == MINUS
    end

    def infinity?
      infinity == INFINITY
    end

    def base_2?
      !!base_2
    end

    def base_8?
      !!base_8
    end

    def base_10?
      !!base_10
    end

    def base_16?
      !!base_16
    end

    def ruby_sign
      plus? ? 1 : -1
    end

    def base_10_whole
      base_10.fetch(:whole, nil)
    end

    def base_10_decimal
      base_10.fetch(:decimal, nil)
    end

    def base_10_exponent
      base_10.fetch(:exponent, nil)
    end

    def base_10_exponent_to_ruby
      raise NotImplementedError unless base_10_exponent
      ::Template::Number.new(base_10_exponent[:number]).to_ruby
    end
    memo_wise :base_10_exponent_to_ruby

    def base_10_to_ruby
      raise NotImplementedError unless base_10?

      total = 0
      total += base_10_whole.to_s.to_i(10).to_d if base_10_whole
      total += base_10_decimal.to_s.to_i(10).to_d / 10 if base_10_decimal
      total *= 10 ** base_10_exponent_to_ruby if base_10_exponent
      total
    end
  end
end
