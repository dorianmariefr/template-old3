class Template
  class Bin
    class Error
      attr_reader :parent

      def initialize(parent: nil, exception:, trace: false)
        @parent = parent
        @exception = exception
        @trace = trace
      end

      def self.print(exception, trace: false)
        error = new(exception: exception.parse_failure_cause, trace: trace)
        error.max_child.print
      end

      def max_child
        tree.flatten.max_by(&:pos)
      end

      def print
        parent.print if parent && trace?

        puts prefix + message
        puts prefix + source
        puts prefix + ' ' * pos + '^'
      end

      def pos
        exception.pos.charpos
      end

      def tree
        [self] + children.map(&:tree)
      end

      private

      attr_reader :exception, :trace

      def index
        i = 0
        error = self
        while error = error.parent
          i += 1
        end
        i
      end

      def prefix
        trace ? '  ' * index : ''
      end

      def message
        exception.message.to_s
      end

      def source
        exception.source.instance_variable_get(:@str).string
      end

      def children
        exception.children.map do |child|
          Template::Bin::Error.new(exception: child, parent: self, trace: trace)
        end
      end

      def trace?
        !!trace
      end
    end
  end
end
