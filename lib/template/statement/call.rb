require_relative "call/parser"

class Template
  class Statement < Node
    class Call < Node
      def initialize(parsed)
        @body = ::Template::Call.new(parsed)
        raise parsed unless call?
      end

      def evaluate(context = default_context)
        body.evaluate(context)
      end

      def render(context = default_context)
        evaluate(context).render
      end

      private

      attr_reader :body

      def call?
        body?
      end

      def body?
        !!body
      end
    end
  end
end
