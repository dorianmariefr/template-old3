# typed: false
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
        tree.flatten.max_by(&:position)
      end

      def print
        parent.print if parent && trace?

        puts "#{prefix}#{message}"

        if lines.size > 1
          puts "#{prefix}#{line_number}: #{line_source}"
          puts "#{prefix}#{" " * line_number.to_s.size}  #{" " * line_position}^"
        else
          puts "#{prefix}#{line_source}"
          puts "#{prefix}#{" " * line_position}^"
        end
      end

      def position
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
        trace ? "  " * index : ""
      end

      def message
        exception.message.to_s
      end

      def line_index
        source[0...position].count("\n")
      end

      def line_number
        line_index + 1
      end

      def lines
        source.lines
      end

      def line_source
        lines[line_index]
      end

      def line_position
        position - lines[0...line_index].map(&:size).sum
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
