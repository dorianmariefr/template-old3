require_relative "multiplication/parser"

class Template
  class Statement < Node
    class Multiplication < Node
      MULTIPLICATION = "*"
      DIVISION = "/"

      def initialize(parsed)
        @left = ::Template::Statement.new(parsed.delete(:left))
        @right = ::Template::Statement.new(parsed.delete(:right))
        @operator = parsed.delete(:operator)
        raise parsed.inspect if parsed.any?
        raise parsed.inspect unless multiplication?
      end

      def evaluate(context = default_context)
        if operator_multiplication?
          left.evaluate(context).times(right.evaluate(context))
        elsif operator_division?
          left.evaluate(context).divided_by(right.evaluate(context))
        else
          raise NotImplementedError
        end
      end

      def render(context = default_context)
        evaluate(context).render
      end

      private

      attr_reader :left, :right, :operator

      def multiplication?
        left? && right? && operator?
      end

      def left?
        !!left
      end

      def right?
        !!right
      end

      def operator?
        !!operator && (operator_multiplication? || operator_division?)
      end

      def operator_multiplication?
        operator == MULTIPLICATION
      end

      def operator_division?
        operator == DIVISION
      end
    end
  end
end
