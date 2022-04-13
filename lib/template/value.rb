require_relative "value/parser"

class Template
  class Statement < Node
    class Value < Node
      def initialize(parsed)
        @body = ::Template::Value.new(parsed)
        raise parsed unless value?
      end

      def evaluate(context = default_context)
        body.evaluate(context)
      end

      def render(context = default_context)
        evaluate(context).render
      end

      private

      attr_reader :body

      def value?
        body?
      end

      def body?
        !!body
      end
    end
  end
end
