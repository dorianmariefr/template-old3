class Template
  class Error < ::StandardError
    class Message
      attr_reader :parent

      def initialize(parent: nil, exception:, verbose: false)
        @parent = parent
        @exception = exception
        @verbose = verbose
      end

      def self.from_exception(exception, verbose: false)
        new(exception: exception.parse_failure_cause, verbose: verbose).max_child
      end

      def max_child
        tree.flatten.max_by(&:position)
      end

      def to_s
        result = ""
        result += parent.to_s if parent && verbose?
        result += "#{prefix}#{message}\n"

        if lines.size > 1
          result += "#{prefix}#{line_number}: #{line_source}\n"
          result += "#{prefix}#{" " * line_number.to_s.size}  #{" " * line_position}^\n"
        else
          result += "#{prefix}#{line_source}\n"
          result += "#{prefix}#{" " * line_position}^\n"
        end

        result
      end

      def position
        exception.pos.charpos
      end

      def tree
        [self] + children.map(&:tree)
      end

      private

      attr_reader :exception, :verbose

      def index
        i = 0
        error = self
        while error = error.parent
          i += 1
        end
        i
      end

      def prefix
        verbose ? "  " * index : ""
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
          self.class.new(exception: child, parent: self, verbose: verbose)
        end
      end

      def verbose?
        !!verbose
      end
    end
  end
end
