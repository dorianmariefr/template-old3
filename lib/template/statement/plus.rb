require_relative "plus/parser"

class Template
  class Statement < Node
    class Plus < Node
      PLUS = "+"
      MINUS = "-"

      def initialize(parsed)
        @left = ::Template::Statement.new(parsed.delete(:left))
        @right = ::Template::Statement.new(parsed.delete(:right))
        @operator = parsed.delete(:operator)
        raise parsed.inspect if parsed.any?
        raise parsed.inspect unless plus?
      end

      def evaluate(context = default_context)
        if operator_plus?
          left.evaluate(context).plus(right.evaluate(context))
        elsif operator_minus?
          left.evaluate(context).minus(right.evaluate(context))
        else
          raise NotImplementedError
        end
      end

      def render(context = default_context)
        evaluate(context).render
      end

      private

      attr_reader :left, :right, :operator

      def plus?
        left? && right? && operator?
      end

      def left?
        !!left
      end

      def right?
        !!right
      end

      def operator?
        !!operator && (operator_plus? || operator_minus?)
      end

      def operator_plus?
        operator == PLUS
      end

      def operator_minus?
        operator == MINUS
      end
    end
  end
end
